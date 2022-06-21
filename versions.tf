terraform {
  required_version = ">= 1.2.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.75"
    }
  }
}
