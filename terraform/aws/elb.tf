# Create a new load balancer
resource "aws_elb" "weblb" {
  name = "weblb-terraform-elb"

  listener {
    instance_port     = 8000
    instance_protocol = "https"
    lb_port           = 80
    lb_protocol       = "https"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 60
  }

  subnets                     = [aws_subnet.web_subnet.id]
  security_groups             = [aws_security_group.web-node.id]
  instances                   = [aws_instance.web_host.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge({
    Name = "foobar-terraform-elb"
    }, {
    git_commit           = "cade7535bd9ac7ae744c7ca3979edd0c37d02e88"
    git_file             = "terraform/aws/elb.tf"
    git_last_modified_at = "2023-03-22 17:28:00"
    git_last_modified_by = "sxilenced@gmail.com"
    git_modifiers        = "nimrodkor/sxilenced"
    git_org              = "mjacquez-palo"
    git_repo             = "terragoat"
    yor_trace            = "b4a83ce9-9a45-43b4-b6d9-1783c282f702"
  })
}