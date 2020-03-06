resource "aws_security_group" "allow_traffic" {
  name = "allow_traffic"
  description = "Allow traffic"
  vpc_id = "vpc-a610d7cd"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port =65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//resource "aws_security_group_rule" "allow" {
//    type = "ingress"
//    from_port = 22
//    to_port = 22
//    protocol = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//    security_group_id = "${aws_security_group.allow_traffic.id}"
//
//    type = "ingress"
//    from_port = 80
//    to_port = 80
//    protocol = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//    security_group_id = "${aws_security_group.allow_traffic.id}"
//  }


resource "aws_key_pair" "key_pair" {
  key_name = "test_1"
  public_key = ""  //add_public_key
}

resource "aws_instance" "web_1" {
  ami = "ami-0520e698dd500b1d1"
  instance_type = "t2.micro"
  availability_zone = "us-east-2c"
  user_data = "${file("files/user-data.txt")}"
  tags = {
    type = "web"
  }
  vpc_security_group_ids = [ "${aws_security_group.allow_traffic.id}" ]
  key_name = "${aws_key_pair.key_pair.id}"
}
