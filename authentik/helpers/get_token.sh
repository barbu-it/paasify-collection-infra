#!/bin/bash

get_token ()
{
  local domain=$1
  local user=$2
  local pass=$3

  curl -k -v -X POST -H 'Content-type: application/x-www-form-urlencoded' -d "grant_type=client_credentials&client_id=mytestclient&username=$user&password=$pass"  https://$domain/application/o/token/
  #curl -k -v -X POST -H 'Content-type: application/x-www-form-urlencoded' -d "client_id=mytestclient&scope=read&grant_type=password&username=$user&password=$pass"  https://$domain/
}

get_password ()
{
  >&2 echo -n Password: 
  read -s password
  echo

  echo $password

}



main ()
{
  local domain=$1
  local user=$2
  pass=$(get_password $user)

  get_token $domain $user $pass
}

main ${@-}
