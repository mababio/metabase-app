output "nginx_ingress_public_ip" {
    value = data.kubernetes_service.nginx_lb.status[0].load_balancer[0].ingress[0].hostname
}