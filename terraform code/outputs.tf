output "alb_dns" {
  value = aws_lb.my_bg_alb.dns_name
}