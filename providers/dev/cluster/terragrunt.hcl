terraform {
    source = "../../../modules//cluster"
}

include {
    path = find_in_parent_folders()
}

dependencies {
    paths = ["../network"]
}

dependency "network" {
    config_path = "../network"
    mock_outputs = {
        vpc_id = "vpc-000000000000"
        private_subnet_ids = ["subnet-00000000000", "subnet-111111111111"]
        public_subnet_ids = ["subnet- 22222222222", "subnet-333333333333"]
      
  }
}

inputs = {
    vpc_id = dependency.network.outputs.vpc_id
    private_subnet_ids = dependency.network.outputs.private_subnet_ids
    public_subnet_ids = dependency.network.outputs.public_subnet_ids
}

