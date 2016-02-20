# Let's Encrypt Utils

## Renew
Renews all certificates that are eligible.

#### Run
```sh
$ sudo ./renew.sh
```

#### Crontab
Runs every saturday
```
* * * * 6 /path/to/repo/renew.sh 2>&1
```
