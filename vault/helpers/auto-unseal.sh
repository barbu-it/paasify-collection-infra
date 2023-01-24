#!/bin/sh

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SECRET_FILE=$DIR/debug/SECRETS.json

vault_extract_keys ()
{
  local file=$1
  local count=${2:-3}

  cat "$file" | grep keys_base64 -A $count | tail -n -$count | sed 's/].*//;s/ *"//;s/".*//'
}

vault_extract_token ()
{
  local file=$1
  cat "$file" | grep root_token | sed 's/.*: "//;s/".*//'
}

vault_unseal ()
{
  local count=${1:-3}

  echo "INFO: Unsealing with $count keys"
  keys=$(vault_extract_keys "$SECRET_FILE" $count)
  
  for key in $keys; do
    echo ""
    echo "INFO: Unsealing ..."
    vault operator unseal $key
  done

}

vault_login ()
{
  echo ""
  echo "INFO: Login with root token ..."
  token=$(vault_extract_token "$SECRET_FILE")
  echo "TOKEN: $token"
  vault login $token
}


main ()
{
  vault_unseal $@
  vault_login
  
  echo
  echo "INFO: Vault is unsealed and logged as root"
  
}

main $@


