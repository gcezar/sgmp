region = "us-west-1"
key_name = "chihweif"
cidr = "172.20.0.0/16"
availability_zones = ["us-west-1a", "us-west-1b"]
public_subnets = ["172.20.0.0/20", "172.20.16.0/20"]
private_subnets = ["172.20.32.0/20", "172.20.48.0/20"]
tsdb_cluster_size = 1
tsdb_volume_size = 100