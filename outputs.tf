output "cluster_name" {
  value       = yandex_mdb_kafka_cluster.this.name
  description = "Kafka cluster name"
}

output "cluster_id" {
  value       = yandex_mdb_kafka_cluster.this.id
  description = "Kafka cluster ID"
}

output "cluster_subnet_ids" {
  value       = yandex_mdb_kafka_cluster.this.subnet_ids
  description = "A list of Kafka cluster subnet IDs"
}

output "cluster_kafka_hosts" {
  value = [
    for host in yandex_mdb_kafka_cluster.this.host : {
      name = host.name
      zone = host.zone_id
    } if host.role == "KAFKA"
  ]
  description = "A set of Kafka hosts"
}

output "cluster_zookeper_hosts" {
  value = [
    for host in yandex_mdb_kafka_cluster.this.host : {
      name = host.name
      zone = host.zone_id
    } if host.role == "ZOOKEEPER"
  ]
  description = "A set of Zookeeper hosts"
}

output "cluster_topics" {
  value = [
    for topic in yandex_mdb_kafka_topic.this : {
      name = topic.name
      id   = topic.id
    }
  ]
  description = "A set of cluster topics"
}

output "cluster_kafka_cname_hosts" {
  value = [
    for host in yandex_dns_recordset.this.*.name :
    trimsuffix(host, ".")
  ]
  description = "A list of Kafka CNAME hosts"
}
