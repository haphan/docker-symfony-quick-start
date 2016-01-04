Docker container to run simple Symfony applications.

## Provision

Provision docker host machine locally an instance called `dev`

```bash
$ docker-machine create --driver virtualbox dev
```
Or provision it using AWS for `production` server. See list of [supported driver](https://docs.docker.com/machine/drivers/)

```bash
$ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C********* --amazonec2-vpc-id vpc-****** production
```

Pointing docker client to the `dev` instance
```bash
$ eval "$(docker-machine env dev)"
```

## Usage

Build image and deploy to docker host
```bash
$ docker build -t haphan/sf2-app-server .
$ docker run -itP -v $PWD:/srv -p 80:80 haphan/sf2-app-server
```

## FAQ

Coming soon