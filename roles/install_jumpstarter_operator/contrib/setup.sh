#!/usr/bin/env bash
set -euxo pipefail
# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
# install jumpstarter cli
uv tool install git+https://github.com/jumpstarter-dev/jumpstarter#subdirectory=packages/jumpstarter-cli
# generate jumpstarter client config
mkdir -p .config/jumpstarter/clients/
cat > .config/jumpstarter/clients/qemu.yaml <<EOF
apiVersion: jumpstarter.dev/v1alpha1
kind: ClientConfig
metadata:
  namespace: jumpstarter-qemu-exporter
  name: $(kubectl auth whoami -o jsonpath="{.status.userInfo.username}")
endpoint: grpc.apps.cluster-lptwk.lptwk.sandbox1315.opentlc.com:443
token: $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
drivers:
  allow: []
  unsafe: True
EOF
# set default config
jmp config client use qemu
# then set JUMPSTARTER_GRPC_INSECURE=1
