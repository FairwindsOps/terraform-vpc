# Single Cluster VPC Builder
This module builds the standard set of VPC subnets we implement for a cluster. This includes VPCs for adjacent services as well as utility and bastion subnets. This module supports a VPC for provisioning _only one cluster_. Previous modules supported building a production and non-prod cluster in the same VPC but with different subnets. This module is intended to support a single prod _or_ non-prod cluster.

## Dynamic Aspects
This module supports any size subnet from a `/16` to `/21`. It will take the input CIDR notation space and divide it evenly to create the desired subnets. The resulting subnets do have some unused space left over but the amount of IPs vary depending on the side of the super-net (CIDR) you provide.

## Known Issues
- Lowest subnet support is a `/21` CIDR range
- Cannot migrate to more or less AZs. If you change AZs at ALL it will break everything. 

# TODO
1. Refactor the use of count
1. Support enabling and disabling "subnet" sets: ie: I don't want to deploy the admin subnet, for example.

## Usage
Need to be used in conjunction with a subnet CIDR generator module (provided).
