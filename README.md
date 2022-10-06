# Project

## Build
```
docker build --tag app-echo:7 .
```

## Run
```
docker run -it --rm -p 6001:5001 app-echo:7
```

## Usage
```
curl -S http://127.0.0.1:6001/api/echo\?text1\=lol2\&lol3\=pop
{"lol3":"pop","text1":"lol2"}

curl -S http://127.0.0.1:6001/-/health
{
  "cpu": {
    "children_system": 0,
    "children_user": 0,
    "iowait": 0,
    "system": 0.01,
    "user": 0.09
  },
  "hostname": "b0dfe286c146",
  "platform": "linux",
  "rss": {
    "data": 25333760,
    "dirty": 0,
    "lib": 0,
    "rss": 31858688,
    "shared": 6586368,
    "text": 4096,
    "vms": 40726528
  }
}
```

## echo application
### Flask
I used flask as it's lightweight and can deliver results with few lines of code. 
### Gunicorn
As production grade http server gunicorn was used. 
### Nginx -- not covered in code 
In front of gunicorn I would add nginx in reverse proxy configration to offload static files if needed in real life examples.
