#!/bin/sh

kubectl get secrets
echo "Input the gitlab-token-xxxx secret name"
read tokenname

echo "Host IP:"
export CURRENT_CONTEXT=$(kubectl config current-context) && export CURRENT_CLUSTER=$(kubectl config view -o go-template="{{\$curr_context := \"$CURRENT_CONTEXT\" }}{{range .contexts}}{{if eq .name \$curr_context}}{{.context.cluster}}{{end}}{{end}}") && echo $(kubectl config view -o go-template="{{\$cluster_context := \"$CURRENT_CLUSTER\"}}{{range .clusters}}{{if eq .name \$cluster_context}}{{.cluster.server}}{{end}}{{end}}")

echo "\n\nCertificate:"
echo `kubectl get secret $tokenname -o jsonpath="{['data']['ca\.crt']}" | base64 --decode`

echo "\n\nToken:"
echo `kubectl get secret $tokenname -o jsonpath="{['data']['token']}" | base64 --decode`

