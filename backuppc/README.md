# BackupPC

## Use cases

Notes:
* BackupPC is usually meant to be installed on a centralized server
  * It can also backup himself
  * Very usuful to backup remote hosts

## Important

When adding for a first time an host, please ensure you choose rsync in: `Edit Config > Xfer > XferMethod = rsync`

To validate ssh host connection, you can run from the host:
```
ssh-keyscan -H 192.168.1.162 >> conf/ssh/known_hosts
ssh-keyscan -H router.example.net >> conf/ssh/known_hosts
chmod 600 conf/ssh/known_hosts
```

Of from inside the container:
```
docker exec -ti -u 1000  backuppc-backuppc-1 bash
ssh-keyscan -H router.example.net >> ~/.ssh/known_hosts
```



