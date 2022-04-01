# Docker instructions

GRM comes in 2 flavors: 
- **X** : your system needs a working X11 server (GRM will start directly)
- **http** : your system does not need a X11 server (you connect to GRM with just a browser)

The main difference is that the http flavor does not need any further installation then docker itself while the X flavor requires to install a X server as well.

# Requirements

## Windows
TBD

## Mac OS

### flavor: X
1. install [docker](https://docs.docker.com/desktop/mac/install/)
1. install [XQuartz](https://www.xquartz.org/)
2. start XQuartz, select preferences menu -> "Security" tab -> check "Allow connections from network clients"
![xquartz preferences](http://mamykin.com/static/d080424a8d38af04964f782f548ade22/57937/XQuartz_Preferences.png)
3. allow local connections by docker. Open a terminal and execute: <br/>
`xhost +localhost`
4. logout from your Mac (required) & reboot (to be sure)

To be able to run GRM you always need to ensure that before starting GRM:
- xquartz is started
- docker is started

### flavor: http
nothing needed other then a browser

To be able to run GRM you always need to ensure that before starting GRM:
- docker is started

## download or build the GRM image (one time)

You can decide if you want to build or use a prebuilt image. If you are unsure I would recommend the prebuilt one.

### prebuilt

Open a terminal and execute: `docker pull steadfasterx/grm:X-<version>` (where `<version>` is the v[ersion number](https://hub.docker.com/repository/docker/steadfasterx/grm/tags))


### build

1. downlad the GRM repository (e.g. by git or in your browser from [here](https://github.com/sfX-android/GRM/tags)). Ensure you extract it when not using git commands.
2. Open a terminal and ensure you are in the directory of the downloaded GRM repository and execute:<br/>`docker build -t grm:latest .` (noted the dot at the end?)


### create the GRM container (one time)

when creating the container 2 paths will be mapped which are both needed so GRM works properly:

  - ssh
  - apps

See [SSH keys](README.md#docker-users-only) for where to find them and their meaning.

1. Open a terminal/shell in the directory where these 2 directories are located. It can be anywhere you like just ensure that the `ssh/` dir contains your ssh key and `apps/` will contain your APKs.
2. Create the container with:
~~~
docker create --name=grm -p 8085:8085 \
    --env='SSHUSER=<PUT-YOUR-USERNAME-HERE>' \
    --env='REPOSERVER=<PUT-YOUR-SSH-SERVER-HERE>' \
    --env='REPOPATH=<PUT-REMOTE-SERVERPATH-HERE>' \
    --mount src="$(pwd)/apps",target=/0_APPS,type=bind \
    --mount src="$(pwd)/ssh",target=/opt/GRM/ssh,type=bind \
    grm:latest
~~~
Obviously replace the 3 `<PUT-....>` tags with real values!

## start GRM

1. `docker start grm`
2. flavor:
     - **X**: GRM will directly start
     - **http**: Open your web browser and connect to: http://localhost:8085



