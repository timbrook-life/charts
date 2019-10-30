bootstrap: consul traefik vault concource
	echo "done"

namespace_core:
	kubectl create namespace core || exit 0
namespace_build:
	kubectl create namespace build || exit 0

concource: namespace_build vault traefik
	helm upgrade -i concourse -f ./concourse_values.yaml stable/concourse --namespace=build 

vault: namespace_core
	helm upgrade -i vault -f ./vault_values.yaml personal/vault --namespace=core --wait 

traefik: namespace_core consul
	helm upgrade -i traefik -f ./traefik_values.yaml stable/traefik --namespace=core --wait

consul: namespace_core
	helm upgrade -i consul -f ./consul_values.yaml stable/consul --namespace=core --wait