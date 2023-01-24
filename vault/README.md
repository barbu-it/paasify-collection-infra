

## Helpers

Unseal helper, mention the required number of keys to unseal, default is 3:

```
docker exec -ti example_infra_vault-vault-1 sh
/helpers # find /helpers/
/helpers/
/helpers/auto-unseal.sh
/helpers/debug
/helpers/debug/SECRETS.json

/ # /helpers/auto-unseal.sh 3
```

Learning vault

https://github.com/xuwang/vault-scripts/blob/master/vault-secrets-the-simple-way.md
https://www.bogotobogo.com/DevOps/Docker/Docker-Vault-Consul.php


# To link with authentic
https://goauthentik.io/integrations/services/hashicorp-vault/
https://support.hashicorp.com/hc/en-us/articles/5547188835731-Configuring-an-OIDC-Auth-Method-with-HCP-Vault
https://developer.hashicorp.com/vault/tutorials/auth-methods/oidc-auth?in=vault%2Fauth-methods
https://docs.gitlab.com/ee/ci/examples/authenticating-with-hashicorp-vault/
https://developer.hashicorp.com/vault/api-docs/auth/jwt#bound_claims


About JWT tokens/claims:
https://developer.hashicorp.com/vault/docs/auth/jwt#claim-specifications-and-json-pointer


About debuggin OIDC:
https://discuss.hashicorp.com/t/error-authenticating-unable-to-authorize-role-oidc/11314/2


Docker integration:
https://www.bogotobogo.com/DevOps/Docker/Docker-Vault-Consul-B.php


Understand: claims : https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-token-claims
JWT REference claims
https://www.iana.org/assignments/jwt/jwt.xhtml
https://www.rfc-editor.org/rfc/rfc7519

Understand scope:
https://auth0.com/docs/get-started/apis/scopes/sample-use-cases-scopes-and-claims



```

vault secrets enable -path=kv kv


    vault auth enable oidc



vault write auth/oidc/config \
         oidc_discovery_url="https://authentik.auth.example.org/application/o/example-vault/" \
oidc_client_id="5ab4ac62c6f855e506c97910c73e9d7ba98bf723" \
oidc_client_secret="6994ed401f323725d71802137cde001e747a2cac4d8d754e7775c79c6b498cc8a271fe070b31dd7eed7ca4edad48681ce337555ff16b2e92e681737d57340215" \
default_role="reader"

vault write auth/oidc/role/reader \
      allowed_redirect_uris="https://vault.infra.example.org/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://vault.infra.example.org/oidc/callback" \
      allowed_redirect_uris="http://localhost:8250/oidc/callback" \
      user_claim="username" \
      bound_audiences="Client ID" \
      verbose_oidc_logging=true \
      policies="reader"
```


# TEST

vault write auth/oidc/role/reader \
      allowed_redirect_uris="https://vault.infra.example.org/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://vault.infra.example.org/oidc/callback" \
      allowed_redirect_uris="http://localhost:8250/oidc/callback" \
      user_claim="username" \
      bound_audiences="Client ID" \
      verbose_oidc_logging=true \
      oidc_scopes=openid,vault \
      policies="reader"


### LEarning Vault





