# Terraform Plan for AKS cluster


The terraform plan is to create `aks` cluster, node-pools and container registery

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subscripton\_id| Azure Subscription ID  | `string` | null | yes |
| resource\_name | Name of resource group | `string` | null | yes |
| cluster\_name | Name of the cluster | `string` | null | yes |
| location | Azure region | `string` | eastus | no |
| vpc\_cidr\_block | VPC CIDR | `string` | 10.0.0.0/18 | no |
| node\_pools | Node pool definition | `map(object{})` | null | yes |


## Outputs

| Name | Description |
|------|-------------|
| azure\_container\_registry\_name| Azure contain registry url  |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.1 |
| azurerm | >= 3.0.0 |


## License

[![License](https://img.shields.io/github/license/SmartloopAI/tf_aks_cluster
)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
