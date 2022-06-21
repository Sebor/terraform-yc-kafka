# Kafka

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_mdb_kafka_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster) | resource |
| [yandex_mdb_kafka_topic.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_assign_public_ip"></a> [cluster\_assign\_public\_ip](#input\_cluster\_assign\_public\_ip) | Determines whether each broker will be assigned a public IP address. The default is false | `bool` | `false` | no |
| <a name="input_cluster_brokers_count"></a> [cluster\_brokers\_count](#input\_cluster\_brokers\_count) | Count of brokers per availability zone. The default is 1 | `number` | `1` | no |
| <a name="input_cluster_deletion_protection"></a> [cluster\_deletion\_protection](#input\_cluster\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `null` | no |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | A description of the Kafka cluster | `string` | `"Kafka cluster managed by terraform"` | no |
| <a name="input_cluster_environment"></a> [cluster\_environment](#input\_cluster\_environment) | Deployment environment of the Kafka cluster.<br>  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_cluster_folder_id"></a> [cluster\_folder\_id](#input\_cluster\_folder\_id) | The ID of the folder that the Kafka cluster belongs to | `string` | `null` | no |
| <a name="input_cluster_kafka_cname"></a> [cluster\_kafka\_cname](#input\_cluster\_kafka\_cname) | Internal CNAME for Kafka hosts | `string` | `null` | no |
| <a name="input_cluster_maintenance_window"></a> [cluster\_maintenance\_window](#input\_cluster\_maintenance\_window) | Maintenance policy of the Kafka cluster | `any` | `null` | no |
| <a name="input_cluster_maintenance_windows"></a> [cluster\_maintenance\_windows](#input\_cluster\_maintenance\_windows) | Maintenance policy of the Kafka cluster<br>  Example:<pre>cluster_maintenance_windows = {<br>      type = "WEEKLY"<br>      day  = "MON<br>      hour = "17"<br>  }</pre> | `map(any)` | `{}` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Kafka cluster name and name prefix for cluster resources | `string` | n/a | yes |
| <a name="input_cluster_schema_registry"></a> [cluster\_schema\_registry](#input\_cluster\_schema\_registry) | Enables managed schema registry on cluster. The default is false | `bool` | `false` | no |
| <a name="input_cluster_security_group_ids"></a> [cluster\_security\_group\_ids](#input\_cluster\_security\_group\_ids) | List of security group IDs to be assigned to cluster | `list(string)` | `[]` | no |
| <a name="input_cluster_subnet_ids"></a> [cluster\_subnet\_ids](#input\_cluster\_subnet\_ids) | IDs of the subnets, to which the Kafka cluster belongs | `list(string)` | `[]` | no |
| <a name="input_cluster_topics"></a> [cluster\_topics](#input\_cluster\_topics) | A map of kafka topics.<br>  Example:<pre>cluster_topics = {<br>    topic1 = {<br>      partitions         = 4<br>      replication_factor = 1<br>      config = {<br>        cleanup_policy = "CLEANUP_POLICY_COMPACT"<br>      }<br>    },<br>    topic2 = {<br>      partitions         = 8<br>      replication_factor = 2<br>    }<br>  }</pre> | `any` | `{}` | no |
| <a name="input_cluster_unmanaged_topics"></a> [cluster\_unmanaged\_topics](#input\_cluster\_unmanaged\_topics) | Allows to use Kafka AdminAPI to manage topics. The default is false | `bool` | `false` | no |
| <a name="input_cluster_users"></a> [cluster\_users](#input\_cluster\_users) | A map of kafka users.<br>  Example:<pre>cluster_users = {<br>    user1 = {<br>      password = passwordone<br>      permissions = [<br>        {<br>          topic_name = "topic1"<br>          role       = "ACCESS_ROLE_CONSUMER"<br>        }<br>      ]<br>    },<br>    user2 = {<br>      password = passwordtwo<br>      permissions = [<br>        {<br>          topic_name = "topic2"<br>          role       = "ACCESS_ROLE_CONSUMER"<br>        },<br>        {<br>          topic_name = "topic3"<br>          role       = "ACCESS_ROLE_PRODUCER"<br>        }<br>      ]<br>    }<br>  }</pre> | `any` | `{}` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of the Kafka cluster | `string` | n/a | yes |
| <a name="input_cluster_vpc_id"></a> [cluster\_vpc\_id](#input\_cluster\_vpc\_id) | ID of the network, to which the Kafka cluster belongs | `string` | n/a | yes |
| <a name="input_cluster_zones"></a> [cluster\_zones](#input\_cluster\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_internal_dns_zone_id"></a> [internal\_dns\_zone\_id](#input\_internal\_dns\_zone\_id) | Internal DNS zone ID for Kafka hosts | `string` | `null` | no |
| <a name="input_internal_dns_zone_name"></a> [internal\_dns\_zone\_name](#input\_internal\_dns\_zone\_name) | Internal DNS zone name for Kafka hosts | `string` | `null` | no |
| <a name="input_kafka_config"></a> [kafka\_config](#input\_kafka\_config) | Configuration of the Kafka subcluster.<br>  Example:<pre>kafka_config = {<br>    resources = {<br>      resource_preset_id = "s2.micro"<br>    }<br>  }</pre> | `map(any)` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Kubernetes cluster resources | `map(any)` | `{}` | no |
| <a name="input_zookeeper_config"></a> [zookeeper\_config](#input\_zookeeper\_config) | Configuration of the ZooKeeper subcluster.<br>  Example:<pre>zookeeper_config = {<br>    resources = {<br>      resource_preset_id = "s2.micro"<br>    }<br>  }</pre> | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Kafka cluster ID |
| <a name="output_cluster_kafka_cname_hosts"></a> [cluster\_kafka\_cname\_hosts](#output\_cluster\_kafka\_cname\_hosts) | A list of Kafka CNAME hosts |
| <a name="output_cluster_kafka_hosts"></a> [cluster\_kafka\_hosts](#output\_cluster\_kafka\_hosts) | A set of Kafka hosts |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kafka cluster name |
| <a name="output_cluster_subnet_ids"></a> [cluster\_subnet\_ids](#output\_cluster\_subnet\_ids) | A list of Kafka cluster subnet IDs |
| <a name="output_cluster_topics"></a> [cluster\_topics](#output\_cluster\_topics) | A set of cluster topics |
| <a name="output_cluster_zookeper_hosts"></a> [cluster\_zookeper\_hosts](#output\_cluster\_zookeper\_hosts) | A set of Zookeeper hosts |
<!-- END_TF_DOCS -->
