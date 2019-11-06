provider "aws" {
  alias  = "shared"
  region = "eu-west-1"

  assume_role {
    role_arn = var.workspace_iam_role_routing
  }
}


resource "aws_alb" "emr" {
  name     = "devfest"
  internal = true

  security_groups = var.alb_security_group
  
  subnets = var.subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = "cbn-aws-logs"
    enabled = true
  }
}

resource "aws_alb_listener" "http-emr" {
  load_balancer_arn = aws_alb.emr.arn

  protocol = "HTTP"
  port     = 80

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https-emr" {
  load_balancer_arn = aws_alb.emr.arn

  protocol = "HTTPS"
  port     = 443

  certificate_arn = var.certificate_arn
  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = 503
    }
  }
}

resource "aws_alb_listener_rule" "emr-hadoop" {
  listener_arn = aws_alb_listener.https-emr.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.emr-hadoop.arn
  }

  condition {
    field  = "host-header"
    values = [var.hadoopDNS]
  }
}

resource "aws_lb_target_group" "emr-hadoop" {
  name   = "devfest-hadoop"
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "ip"
  port        = "8088"
  health_check {
    port = "traffic-port"
    path = "/cluster"

    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
    timeout             = 5
  }

  tags = {
    Environment = "TEST"
  }
}

resource "aws_lb_target_group_attachment" "emr-hadoop" {
  target_group_arn = aws_lb_target_group.emr-hadoop.arn
  target_id = replace(
    element(
      split(
        ".",
        substr(aws_emr_cluster.emr_cluster.master_public_dns, 3, -1),
      ),
      0,
    ),
    "-",
    ".",
  )
  port = 8088
}

resource "aws_alb_listener_rule" "emr-livy" {
  listener_arn = aws_alb_listener.https-emr.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.emr-livy.arn
  }

  condition {
    field  = "host-header"
    values = [var.livyDNS]
  }
}

resource "aws_lb_target_group" "emr-livy" {
  name   = "devfest-livy"
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "ip"
  port        = "8998"
  health_check {
    port = "traffic-port"
    path = "/ui"

    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
    timeout             = 5
  }

  tags = {
    Environment = "TEST"
  }
}

resource "aws_lb_target_group_attachment" "emr-livy" {
  target_group_arn = aws_lb_target_group.emr-livy.arn
  target_id = replace(
    element(
      split(
        ".",
        substr(aws_emr_cluster.emr_cluster.master_public_dns, 3, -1),
      ),
      0,
    ),
    "-",
    ".",
  )
  port = 8998
}


resource "aws_route53_record" "emr-internal-empathybroker-com" {
  provider = aws.shared
  zone_id  = var.zone_id
  name     = var.emrDNS
  type     = "A"
  records = [replace(
    element(
      split(
        ".",
        substr(aws_emr_cluster.emr_cluster.master_public_dns, 3, -1),
      ),
      0,
    ),
    "-",
    ".",
  )]
  ttl = "300"
}

resource "aws_route53_record" "hadoop-internal-empathybroker-com" {
  provider = aws.shared
  zone_id  = var.zone_id
  name     = var.hadoopDNS
  type     = "A"

  alias {
    name                   = aws_alb.emr.dns_name
    zone_id                = aws_alb.emr.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "livy-internal-empathybroker-com" {
  provider = aws.shared
  zone_id  = var.zone_id
  name     = var.livyDNS
  type     = "A"

  alias {
    name                   = aws_alb.emr.dns_name
    zone_id                = aws_alb.emr.zone_id
    evaluate_target_health = false
  }
}



