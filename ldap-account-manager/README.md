# LDAP Account Manager

## Quickstart

You need to copy existing data first, which is not exactly cloud ready. This 
will OVERWRITE any existing local config, please commit to git or backup before:
```
docker run --rm -it -v $PWD:/export ldapaccountmanager/lam:8.1 /bin/sh -c 'mkdir -p /export/conf && cp -a /var/lib/ldap-account-manager/config/* /export/conf && rm /export/conf/config.cfg && cp /etc/ldap-account-manager/config.cfg /export/conf/'
```

Then change default password (you will have to change it later in the web UI to encrypt it):
```
sed -i 's/^password:.*/password: APPLICATION_ADMIN_PASS_jsdhfkjg/' conf/config.cfg
```

And fix permissions:
```
chown -R 33:33 data/sess/
```

### Old method

Other way to do:
```
docker run -d --name lam_tmp --rm ldapaccountmanager/lam:latest 
docker cp lam_tmp:/var/lib/ldap-account-manager/config/ .
docker stop lam_tmp
```

```

mkdir -p data/sess
mv config conf
sudo chown -R 33:33 data/ conf/
sudo chmod go+rx conf/
sudo chmod go+r conf/*
sudo rm conf/config.cfg
sudo cp conf/config.cfg.sample conf/config.cfg

sudo sed -i 's/^password:.*/password: admin/' conf/config.cfg
```


