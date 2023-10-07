# Minio - S3

## Notes

* When ldap backend is enabled, groups and user management is not available anymore in the UI
  * you need to set a default group policy BEFORE enabling ldap backend
  * either use mc admin
  * either define a new group: cn=minio_admins,ou=groups,dc=example,dc=com and assign admin policies in the web ui
  * Recreate minio service with ldap support, it should work
  # See documentation: https://min.io/docs/minio/linux/administration/identity-access-management/ad-ldap-access-management.html#id2


### Integrate with authentik:

https://github.com/outline/outline/discussions/2716



To run the mc client

Get the stopped client name:
```
paasify ps
```

Get into it:
```
docker start -ai example_minio-mc-1
```

Login
```
mc config host add local https://minio.example.org APP_KEY APP_SECRET
mc alias list
```

Example:
```
bash-4.4# mc admin user list  local
enabled    root                  consoleAdmin,read...
enabled    app-gitea             app-gitea-rw        
enabled    backup-ci             jzn-backups-rw      
enabled    drone-ci              jzn-sites-rw        
bash-4.4# mc admin policy list local
readonly
readwrite
writeonly
app-gitea-rw
consoleAdmin
diagnostics
jzn-backups-rw
jzn-sites-rw
```

