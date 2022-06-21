variable "cluster_name" {
  type        = string
  description = "Kafka cluster name and name prefix for cluster resources"
}

variable "cluster_description" {
  type        = string
  default     = "Kafka cluster managed by terraform"
  description = "A description of the Kafka cluster"
}

variable "cluster_folder_id" {
  type        = string
  default     = null
  description = "The ID of the folder that the Kafka cluster belongs to"
}

variable "cluster_environment" {
  type        = string
  default     = "PRODUCTION"
  description = <<EOF
  Deployment environment of the Kafka cluster.
  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION
  EOF

  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.cluster_environment)
    error_message = "Environment must be 'PRODUCTION' or 'PRESTABLE'."
  }
}

variable "cluster_vpc_id" {
  type        = string
  description = "ID of the network, to which the Kafka cluster belongs"
}

variable "cluster_version" {
  type        = string
  description = "Version of the Kafka cluster"
}

variable "cluster_subnet_ids" {
  type        = list(string)
  default     = []
  description = "IDs of the subnets, to which the Kafka cluster belongs"
}

variable "cluster_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "cluster_assign_public_ip" {
  type        = bool
  default     = false
  description = "Determines whether each broker will be assigned a public IP address. The default is false"
}

variable "cluster_deletion_protection" {
  type        = bool
  default     = null
  description = "Inhibits deletion of the cluster"
}

variable "cluster_unmanaged_topics" {
  type        = bool
  default     = false
  description = "Allows to use Kafka AdminAPI to manage topics. The default is false"
}

variable "cluster_schema_registry" {
  type        = bool
  default     = false
  description = "Enables managed schema registry on cluster. The default is false"
}

variable "cluster_maintenance_window" {
  type        = any
  default     = null
  description = "Maintenance policy of the Kafka cluster"
}

variable "cluster_brokers_count" {
  type        = number
  default     = 1
  description = "Count of brokers per availability zone. The default is 1"
}

variable "cluster_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be assigned to cluster"
}

variable "cluster_maintenance_windows" {
  type        = map(any)
  default     = {}
  description = <<EOF
  Maintenance policy of the Kafka cluster
  Example:
  ```
  cluster_maintenance_windows = {
      type = "WEEKLY"
      day  = "MON
      hour = "17"
  }
  ```
  EOF
}

variable "kafka_config" {
  type        = map(any)
  description = <<EOF
  Configuration of the Kafka subcluster.
  Example:
  ```
  kafka_config = {
    resources = {
      resource_preset_id = "s2.micro"
    }
  }
  ```
  EOF
}

variable "zookeeper_config" {
  type        = map(any)
  default     = {}
  description = <<EOF
  Configuration of the ZooKeeper subcluster.
  Example:
  ```
  zookeeper_config = {
    resources = {
      resource_preset_id = "s2.micro"
    }
  }
  ```
  EOF
}

variable "cluster_users" {
  type        = any
  default     = {}
  description = <<EOF
  A map of kafka users.
  Example:
  ```
  cluster_users = {
    user1 = {
      password = passwordone
      permissions = [
        {
          topic_name = "topic1"
          role       = "ACCESS_ROLE_CONSUMER"
        }
      ]
    },
    user2 = {
      password = passwordtwo
      permissions = [
        {
          topic_name = "topic2"
          role       = "ACCESS_ROLE_CONSUMER"
        },
        {
          topic_name = "topic3"
          role       = "ACCESS_ROLE_PRODUCER"
        }
      ]
    }
  }
  ```
  EOF
}

variable "cluster_topics" {
  type        = any
  default     = {}
  description = <<EOF
  A map of kafka topics.
  Example:
  ```
  cluster_topics = {
    topic1 = {
      partitions         = 4
      replication_factor = 1
      config = {
        cleanup_policy = "CLEANUP_POLICY_COMPACT"
      }
    },
    topic2 = {
      partitions         = 8
      replication_factor = 2
    }
  }
  ```
  EOF
}

variable "cluster_kafka_cname" {
  type        = string
  default     = null
  description = "Internal CNAME for Kafka hosts"
}

variable "internal_dns_zone_id" {
  type        = string
  default     = null
  description = "Internal DNS zone ID for Kafka hosts"
}

variable "internal_dns_zone_name" {
  type        = string
  default     = null
  description = "Internal DNS zone name for Kafka hosts"
}

variable "labels" {
  type        = map(any)
  default     = {}
  description = "A set of key/value label pairs to assign to the Kubernetes cluster resources"
}
