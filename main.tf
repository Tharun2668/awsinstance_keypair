provider "aws" {
  region = "ap-south-1"
}


// here first we are creating a keypair 
resource "tls_private_key" "pterra" {
  algorithm = "RSA"
  rsa_bits = "4096"
}

//here we givig public key to aws instance it will verify with private key and it allows us to login into instance
resource "aws_key_pair" "keypair1" {
  key_name = "terrform_key"
  public_key = tls_private_key.pterra.public_key_openssh
}
//here we are storing the private key in our locatonmachine it will store in project directory
resource "local_file" "privatekeys" {
    content = tls_private_key.pterra.private_key_pem
  filename = "terraformarungit"
}

  

resource "aws_instance" "multipleinstances" {

    ami = "xxxxxxxxxxxxx"  // mention instance id
    instance_type = "t2.micro" // use can use your  on type just for ref i mention t2.micro
    //here ley name is the public key name we are passing it 

    key_name = aws_key_pair.keypair1.key_name
    tags = {
      Name = "multiec2s"
    }
  
}
