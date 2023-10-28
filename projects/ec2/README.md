# ec2
Provisions `n` number of EC2 instances in default VPC. Instaces have internet access, can communicate between each other and can be accessed via ssh from internet. For additional access from internet check `ingress_rules_internet` variable.

### resources
* `ec2 (multiple)`
* `ec2 key pair`
* `security group`