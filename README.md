# Let's Encrypt Utils
Let's Encrypt Utils for nginx integration

## Renew
Renews all certificates that are eligible.

#### Run
```sh
$ sudo ./renew.sh
```

#### Crontab
Runs every saturday
``` sh
* * * * 6 /path/to/repo/renew.sh 2>&1
```

## Create

#### Run
Before create a certificate, in order to Let's Encrypt verifies the ownership of the domain you must serve that domain on your server. 
Add this configuration to your nginx
```
server {
  listen              80;
  listen              [::]:80;
  server_name         letsencrypt.tomahock.com letsencrypt.tomahock.com;
  location '/.well-known/acme-challenge' {
  default_type "text/plain";
    root        /tmp/letsencrypt-auto;
  }

  location / {
    return              301 https://$server_name$request_uri;
  }
}
```

After restart nginx run
```sh
$ sudo ./create.sh domain.com
```

The certificates will be in the dir
``` sh
/etc/letsencrypt/live/letsencrypt.tomahock.com
```

### TODO
* One binary to run them all
* -h heelllppppp
* Better output
* Quite mode for crontab (http://unix.stackexchange.com/a/46801)
* Create nginx configurations
* Go on a space flight

