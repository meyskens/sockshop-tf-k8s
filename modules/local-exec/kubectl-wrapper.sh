#!/bin/bash

# kubectl-wrapper.sh server certificate-authority client-certificate client-key ARGS ...

SERVER=$1; shift
CERTIFICATE_AUTHORITY=$1; shift
TOKEN=$1; shift

temp_dir="$(mktemp -d)"
trap "rm -rf $temp_dir" EXIT

certificate_authority_file="$temp_dir/ca"
printf -- "$CERTIFICATE_AUTHORITY" > "$certificate_authority_file"


kubectl --token="${TOKEN}" \
        --certificate-authority="${certificate_authority_file}" \
        --server="${SERVER}" \
        --kubeconfig=/dev/null \
        $@
