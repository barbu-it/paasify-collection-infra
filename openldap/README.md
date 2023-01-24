# OpenLDAP Server

## Connecting as admin

You can use JXplorer as LDAP client to test it out:
* Host: Your LDAP IP
* Port: Your LDAP port (389)
* Base DN: dc=example,dc=org
* User DN: cn=admin,dc=example,dc=org
* Password: LDAP Admin password

## Note about TLS

LDAP port: 389
LDAPS port: 636


## Self-serve configuration

This little helper to run queries:
```
alias test_ldap='ldapsearch -x -D "$CLIENT_BIND_DN" -w "$LDAP_ADMIN_PASSWORD" -b "$CLIENT_BASE_DN" '
test_ldap '(&(objectClass=groupOfUniqueName)...'
```

## LUM configuration

For lUM, an initial config step is required:

https://lum.dev.box/setup/

If you want to connect with JXplorer:
IP: your epxosed IP ....
BASE_DN: dc=my,dc=domain
User DN: cn=admin,dc=dev,dc=box
User password: LDAPADMINPASS

## Overlays

List enabled overlays:
```
slapcat -n 0 | grep olcModuleLoad
```

Enable Overlay:
```
ldapmodify -Q -Y EXTERNAL -H ldapi:///
dn: cn=module{0},cn=config
changetype: modify
add: olcModuleLoad
olcModuleLoad: dynlist

```
Example of configuration loading:
```
# cat configure_dynlist.ldif
dn: olcOverlay=dynlist,olcDatabase={1}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcDynamicList
olcOverlay: dynlist
olcDlAttrSet: groupOfNames labeledURI member
#olcDlAttrSet: obPerson labeledURI obMemberOf
root@19ed5d44253b:/etc/ldap/slapd.d/import_ldif# ldapadd -H ldapi:/// -Y EXTERNAL -f configure_dynlist.ldif 
```


## Inspect openldap

To get an overview of overlays, checkou man pages starting with `slapo-.*` [here](https://www.symas.com/symas-man-pages)

To get a list of available mods/overlays:
```
docker run --rm -it --entrypoint bash osixia/openldap:latest -c 'ls -1 /usr/lib/ldap/*.so'
```

Dump the config:
```
ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config

```

List enabled overlays (is it a load order ?):
```
slapcat -n 0 | grep olcModuleLoad
olcModuleLoad: {0}back_mdb
olcModuleLoad: {1}memberof
olcModuleLoad: {2}refint

```

And their given config:
```
slapcat -n 0 | grep --color=always  -A 30  'dn: olcOverlay'
```

List all laoded schemas:
```
ldapsearch -x -s base -b "cn=subschema" objectclasses | grep -o 'NAME .* DESC' | awk '{print $2}' | sort
```
TO see loaded schemas:
```
tree cn\=config/cn\=schema/
cn=config/cn=schema/
├── cn={0}core.ldif
├── cn={1}cosine.ldif
├── cn={2}inetorgperson.ldif
├── cn={3}rfc2307bis.ldif
├── cn={4}ppolicy.ldif
├── cn={5}kopano.ldif
├── cn={6}openssh-lpk.ldif
├── cn={7}postfix-book.ldif
├── cn={8}samba.ldif
└── cn={9}dyngroup.ldif
```

To load a schema:
```
ldapadd -H ldapi:/// -Y EXTERNAL -f schema/dyngroup.ldif
```

Interesting links:

### Cookbooks

* Nested dynamic groups
  * https://github.com/osixia/docker-openldap/issues/355
* ACL tweaking
  * https://github.com/osixia/docker-openldap/issues/176
* Try to get a anonymous user to get infos
    * https://github.com/osixia/docker-openldap/issues/186


### ACL

To view ACLs:
```
ldapsearch -H ldapi:// -Y EXTERNAL -LLL -Q -b 'olcDatabase={1}mdb,cn=config'  -s base
```

Tip: Can you edit offline config dir ?

