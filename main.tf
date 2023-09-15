resource "yandex_mdb_kafka_cluster" "this" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.cluster_environment
  folder_id   = var.cluster_folder_id

  network_id         = var.cluster_vpc_id
  subnet_ids         = var.cluster_subnet_ids
  security_group_ids = var.cluster_security_group_ids

  deletion_protection = var.cluster_deletion_protection

  config {
    version          = var.cluster_version
    brokers_count    = var.cluster_brokers_count
    zones            = var.cluster_zones
    assign_public_ip = var.cluster_assign_public_ip
    unmanaged_topics = var.cluster_unmanaged_topics
    schema_registry  = var.cluster_schema_registry

    dynamic "kafka" {
      for_each = var.kafka_config

      content {
        resources {
          resource_preset_id = lookup(kafka.value, "resource_preset_id", "s2.micro")
          disk_type_id       = lookup(kafka.value, "disk_type_id", "network-ssd")
          disk_size          = lookup(kafka.value, "disk_size", 10)
        }

        dynamic "kafka_config" {
          for_each = try(kafka.value.custom, [])

          content {
            compression_type                = lookup(kafka_config.value, "compression_type", null)
            log_flush_interval_messages     = lookup(kafka_config.value, "log_flush_interval_messages", null)
            log_flush_interval_ms           = lookup(kafka_config.value, "log_flush_interval_ms", null)
            log_flush_scheduler_interval_ms = lookup(kafka_config.value, "log_flush_scheduler_interval_ms", null)
            log_retention_bytes             = lookup(kafka_config.value, "log_retention_bytes", null)
            log_retention_hours             = lookup(kafka_config.value, "log_retention_hours", null)
            log_retention_minutes           = lookup(kafka_config.value, "log_retention_minutes", null)
            log_retention_ms                = lookup(kafka_config.value, "log_retention_ms", null)
            log_segment_bytes               = lookup(kafka_config.value, "log_segment_bytes", null)
            log_preallocate                 = lookup(kafka_config.value, "log_preallocate", null)
            num_partitions                  = lookup(kafka_config.value, "num_partitions", null)
            default_replication_factor      = lookup(kafka_config.value, "default_replication_factor", null)
          }
        }
      }
    }

    dynamic "zookeeper" {
      for_each = length(var.cluster_zones) > 1 ? var.zookeeper_config : {}

      content {
        resources {
          resource_preset_id = lookup(zookeeper.value, "resource_preset_id", "s2.micro")
          disk_type_id       = lookup(zookeeper.value, "disk_type_id", "network-ssd")
          disk_size          = lookup(zookeeper.value, "disk_size", 10)
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = var.cluster_maintenance_windows

    content {
      type = lookup(maintenance_window.value, "type", "WEEKLY")
      day  = lookup(maintenance_window.value, "day", null)
      hour = lookup(maintenance_window.value, "hour", null)
    }
  }

  labels = var.labels
}

resource "yandex_mdb_kafka_topic" "this" {
  for_each = var.cluster_topics

  cluster_id         = yandex_mdb_kafka_cluster.this.id
  name               = each.key
  partitions         = each.value["partitions"]
  replication_factor = each.value["replication_factor"]

  dynamic "topic_config" {
    for_each = contains(keys(each.value), "config") ? [1] : []

    content {
      cleanup_policy        = lookup(each.value["config"], "cleanup_policy", null)
      compression_type      = lookup(each.value["config"], "compression_type", null)
      delete_retention_ms   = lookup(each.value["config"], "delete_retention_ms", null)
      file_delete_delay_ms  = lookup(each.value["config"], "file_delete_delay_ms", null)
      flush_messages        = lookup(each.value["config"], "flush_messages", null)
      flush_ms              = lookup(each.value["config"], "flush_ms", null)
      min_compaction_lag_ms = lookup(each.value["config"], "min_compaction_lag_ms", null)
      retention_bytes       = lookup(each.value["config"], "retention_bytes", null)
      retention_ms          = lookup(each.value["config"], "retention_ms", null)
      max_message_bytes     = lookup(each.value["config"], "max_message_bytes", null)
      min_insync_replicas   = lookup(each.value["config"], "min_insync_replicas", null)
      segment_bytes         = lookup(each.value["config"], "segment_bytes", null)
      preallocate           = lookup(each.value["config"], "preallocate", null)
    }
  }
}

resource "yandex_mdb_kafka_user" "this" {
  for_each = var.cluster_users

  cluster_id = yandex_mdb_kafka_cluster.this.id
  name       = each.key
  password   = each.value["password"]
  dynamic "permission" {
    for_each = try(each.value["permissions"], [])

    content {
      topic_name = permission.value.topic_name
      role       = permission.value.role
    }
  }
}

resource "yandex_dns_recordset" "this" {
  count = var.cluster_kafka_cname != null && var.internal_dns_zone_id != null && var.internal_dns_zone_name != null ? length(var.cluster_zones) : 0

  zone_id = var.internal_dns_zone_id
  name    = "${var.cluster_kafka_cname}-${count.index}.${var.internal_dns_zone_name}."
  type    = "CNAME"
  ttl     = 360
  data    = [[for i in yandex_mdb_kafka_cluster.this.host : i.name if i.role == "KAFKA"][count.index]]
}
