# Authelia

Authelia is an open-source authentication and authorization server and portal fulfilling the identity and access management (IAM) role of information security in providing multi-factor authentication and single sign-on (SSO) for your applications via a web portal. It acts as a companion for common reverse proxies.

Links:

* [Website](https://www.authelia.com/)

# Quick start

You are required to generate secrets for the following vars:
```
authelia_jwt_secret: R2r2lTfBkcVUdpc...
authelia_session_secret: V1geCh3jBps8quPKt1...
authelia_storage_encryption_key: SBHofU7oopyJdQgDMEF...
```
You can use this command to generate acceptable secrets:
```
docker run authelia/authelia:latest authelia crypto rand --length 64 --charset alphanumeric
```

# Auth backends

About user management: [Traefik Doc](https://docs.ibracorp.io/authelia/authelia/configuration)

## User Backend

To configure users
```
cat conf/users_database.yml 
users:
  john:
    displayname: "John Doe"
    password: "$argon2id$v=19$m=65536,t=3,p=2$BpLnfgDsc2WD8F2q$o/vzA4myCqZZ36bUGsDY//8mKUYNZZaR0t4MFFSs+iM"
    email: john.doe@authelia.com
    groups:
      - admins
      - dev
```

Generate a user/password for simple auth:
```
docker run --rm authelia/authelia:latest authelia hash-password 'yourpassword'
```
## LDAP Backend

# ACL

Configure your authelia ACL's here:
```
conf/configuration.local.yml
```


