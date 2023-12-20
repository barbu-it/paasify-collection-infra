# VaultWarden


## Signup

Set for the first time, if you want to be able to register:
```
app_signup_allowed: true
```

Enable user registration with `app_user_signup: true` or limit user signup on specific domains with `app_user_domains: domain1.com,domain2.com`


## Admin Page

See: https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page

Generate token for admin page:

```
docker run --rm -it vaultwarden/server /vaultwarden hash
# AS clear text: openssl rand -base64 48
```

Then enable as paasify vars:
```
app_admin_token: ...
```

 
