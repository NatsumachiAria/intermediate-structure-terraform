### How to create VPC and networking component.

1. Create VPC, Internet Gateway, Elastic-IP, Public-asso-Subnet first.

   1.1 Comment NAT Gateway, Route Table and the rest [RTB need to reference public & private subnet in another directory].
       
      if don't comment NAT-GW, Route Table, The prompt will show error, There are no referrent existed. 
   
   1.2 Comment data.tf in this folder [Reason same as 1.1].
   
   1.3 Save all files and run "terraform apply --auto-approve" command to create resources.

2. Go to folder ..envs/dev/subnet, then create public & private subnets.

3. Remove comment NAT Gateway, Route table and the rest. then run "terraform apply --auto-approve" to complete networking
   public & private zones.



### How to delete all resources.

//Cannot delete directly because the referrent resources cannot delete

1. Delete public and private subnets from folder ../subnet first.

2. Go to folder ../vpc, then comment file data.tf
   
   2.1 Comment "aws_route_table_association" "public-rtb-asc" , "aws_route_table_association" "private-rtb-asc"
   
      then run "terraform apply --auto-approve"
   
      terraform is going to delete that resources automatically.
   
   2.2 Run "terraform destroy --auto-approve" 