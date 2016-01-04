Docker container to run simple Symfony applications.

## Docker daemon (for Linux based OS)
So if you are using Windows or Mac, you cannot enjoy this luxury. Move on and try to provision docker host with `docker-machine` in the below section.

Make sure you are running kernel >= 3.10

```bash
$ uname -r
3.11.0-15-generic
```

Install docker engine (Example below for ubuntu 15.10). Refer to full documentation [here](https://docs.docker.com/engine/installation/ubuntulinux/)

```bash
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

$ echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" > /etc/apt/sources.list.d/docker.list

$ sudo apt-get update && sudo apt-get install linux-image-extra-$(uname -r)
```
Verify installation

```bash
$ docker info
```

## Provisoning docker host (for Non-Linux or remote docker instance)

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