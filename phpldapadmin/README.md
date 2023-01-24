# PHPLdapAdmin


## Quickstart

### Config tag

To manage your own config, you must copy config example first:
```
docker run --rm -ti --entrypoint bin/bash -v $PWD:/export osixia/phpldapadmin:latest  -c 'mkdir -p /export/conf && cp -r /container/service/phpldapadmin/assets/config/config.php   /export/conf/'
```

If the templates profile is enabled, you need then to populate them first:
```
docker run --rm -ti --entrypoint bin/bash -v $PWD:/export osixia/phpldapadmin:latest  -c 'mkdir -p /export/templates && cp -r /var/www/phpldapadmin_bootstrap/templates/*   /export/templates/'
```
