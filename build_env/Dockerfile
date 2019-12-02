FROM centos:7

COPY ./repos.repo /etc/yum.repos.d/repos.repo

RUN yum update -y && yum install epel-release -y
RUN yum update -y && yum install -y \
  python \
  git \
  kubectl \
  openssl \
  s3cmd \
  jq \
  --skip-broken

WORKDIR /root
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get >get_helm.sh
RUN chmod +x get_helm.sh
RUN ./get_helm.sh --version v2.12.3
RUN curl -sL https://github.com/digitalocean/doctl/releases/download/v1.13.0/doctl-1.13.0-linux-amd64.tar.gz | tar -xzv
RUN mv ./doctl /usr/local/bin

RUN mkdir .kube
