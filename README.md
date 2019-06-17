# Ansiform
This Repo gives a basic understanding of how we can deploy a kubernetes cluster using terraform, Ansible and Kubernetes. It also tells you about setting up Jenkins in Pod while connecting to a docker registry.

It also touches upon steps to setup istio with monitoring.


1. Install Terraform and Ansible
2. Get Gcloud credentials in json file.
3. Use those credentials in "provider" section of terraform and use the files inside "Terraform" directory.

4. Deploy ansible playbooks in "Ansible" Folder in following order:
  a. user-setup
  b. initial-setup
  c. master-setup
  d. worker-setup
  
5. Get into Jenkins-in-pod directory and follow following steps
  a. Create Service account named "Jenkins"
  b. Create clusterRoleBinding to give acceess

kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts:jenkins --namespace=jenkins

  c. get the token to make jenkin connect to

kubectl get -n <your-namespace> sa/jenkins --template='{{range .secrets}}{{ .name }} {{end}}' | xargs -n 1 kubectl -n <your-namespace> get secret --template='{{ if .data.token }}{{ .data.token }}{{end}}' | head -n 1 | base64 -d -

  d. Create image using jenkins Dockerfile
  e. Deploy jenkins as a "Deployment" and deploy the serivces to communicate with Jenkins
  f. add the pipeline code to get the slave runningon demand
  
6. Run following commands to setup docker registry:

docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v /opt/docker/containers/docker-registry/registry:/var/lib/registry \
  -v /opt/docker/containers/docker-registry/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  registry:2


docker run --entrypoint htpasswd registry -Bbn user 123 > /opt/docker/containers/docker-registry/auth/htpasswd


#Add following entry to systemd file

/etc/docker/daemon.json
{ "insecure-registries":["myregistry.example.com:5000"] }



7. Get into istio directory and follow following steps:

