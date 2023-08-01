resource "helm_release" "nfd" {
  name              = "node-features"
  repository        = "https://kubernetes-sigs.github.io/node-feature-discovery/charts/"
  chart             = "node-feature-discovery"
  namespace         = "tooling"
  max_history       = 2
  dependency_update = true
  version           = "0.13.1"
  create_namespace  = true
  timeout           = 180

}
