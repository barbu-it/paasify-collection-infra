
# Gitea




# Oauth2

Can't be made via the API, but in the db: » mysql » gitea » login_source » 
```
SELECT *
FROM `login_source`
LIMIT 50
```

Or integration must be done via UI which is not that automatable ...


## Volume creation

To create required volumes, there is the command line to run first:
```
cat docker-compose.run.yml | python3 -c 'import sys, yaml, json; y=yaml.safe_load(sys.stdin.read()); print(json.dumps(y))' | jq -r '.volumes | keys[] as $key| "mkdir -p " + .[$key].driver_opts.device + "; docker volume create -d " + .[$key].driver + " -o type="  + .[$key].driver_opts.o +  " -o device=" + .[$key].driver_opts.device  + " devbox_gitea_" + $key '
```
