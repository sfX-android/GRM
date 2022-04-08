# Docker instructions

GRM comes in 2 flavors: 
- **X** : your system needs a working X11 server (GRM will start directly)
- **http** : your system does not need a X11 server (you connect to GRM with just a browser)

The main difference is that the http flavor does not need any further installation then docker itself while the X flavor requires to install a X server as well.

# Requirements

## Windows

### flavor: X

1. install [docker](https://docs.docker.com/desktop/windows/install/)
2. install [VcXsrv](https://sourceforge.net/projects/vcxsrv/) (see next lines)

Unfortunately (?) I do not own a Windows system to test the following guide but it seems [VcXsrv](https://sourceforge.net/projects/vcxsrv/) is the best choice these days for using X on Windows. If you find any better or problems with that let me know ;)

For installing VcXsrv follow this [Guide](https://dev.to/darksmile92/run-gui-app-in-linux-docker-container-on-windows-host-4kde) -> stop at _"Create a Dockerfile"_. you don't need to do that or the rest of the guide ;)

### flavor: http
1. install [docker](https://docs.docker.com/desktop/windows/install/)
2. apart from a (modern) browser nothing else is needed

To be able to run GRM you always need to ensure that before starting GRM:
- docker is started


## Mac OS

### flavor: X
1. install [docker](https://docs.docker.com/desktop/mac/install/)
2. install [XQuartz](https://www.xquartz.org/)
3. start XQuartz, select preferences menu -> "Security" tab -> check "Allow connections from network clients"
![xquartz preferences](http://mamykin.com/static/d080424a8d38af04964f782f548ade22/57937/XQuartz_Preferences.png)
4. allow local connections by docker. Open a terminal and execute: <br/>
`xhost +localhost`
5. logout from your Mac (required) & reboot (to be sure)

To be able to run GRM you always need to ensure that before starting GRM:
- xquartz is started
- docker is started

### flavor: http
1. install [docker](https://docs.docker.com/desktop/mac/install/)
2. apart from a (modern) browser nothing else is needed

To be able to run GRM you always need to ensure that before starting GRM:
- docker is started

## download or build the GRM image (one time)

You can decide if you want to build or use a prebuilt image. If you are unsure I would recommend the prebuilt one.

### prebuilt

Recommended and easiest approach.

Open a terminal and execute: `docker pull steadfasterx/grm:X-<version>` (where `<version>` is the v[ersion number](https://hub.docker.com/repository/docker/steadfasterx/grm/tags))


### build

If you want to build it instead:

1. downlad the GRM repository (e.g. by git or in your browser from [here](https://github.com/sfX-android/GRM/tags)). Ensure you extract it when not using git commands.
2. Open a terminal and ensure you are in the directory of the downloaded GRM repository and execute:<br/>`docker build -t grm:latest .` (noted the dot at the end?)


### Windows | Mac OS: create the GRM container (one time, prebuilt or self-built)

when creating the container 2 paths will be mapped which are both needed so GRM works properly:

  - ssh
  - apps

See [SSH keys](README.md#docker-users-only) for where to find them and their meaning.

1. Open a terminal/shell in the directory where these 2 directories are located. It can be anywhere you like just ensure that the `ssh/` dir contains your ssh key and `apps/` will contain your APKs.
2. Create the container<br/>(replace `<PUT-....>` tags with real values and `grm:<flavor>-<version>` with the flavor and version (e.g. `grm:X-latest` or `grm:http-v1.3`)):
 - **http flavor:**
~~~
docker create --name=grm -p 8085:8085 \
    --env='SSHUSER=<PUT-YOUR-USERNAME-HERE>' \
    --env='REPOSERVER=<PUT-YOUR-SSH-SERVER-HERE>' \
    --env='REPOPATH=<PUT-REMOTE-SERVERPATH-HERE>' \
    --mount src="$(pwd)/apps",target=/0_APPS,type=bind \
    --mount src="$(pwd)/ssh",target=/opt/GRM/ssh,type=bind \
    steadfasterx/grm:http-<version>
~~~
 - **X flavor:**
~~~
docker create --name=grm --net=host --env='DISPLAY' \
    --env='SSHUSER=<PUT-YOUR-USERNAME-HERE>' \
    --env='REPOSERVER=<PUT-YOUR-SSH-SERVER-HERE>' \
    --env='REPOPATH=<PUT-REMOTE-SERVERPATH-HERE>' \
    --mount src="$(pwd)/apps",target=/0_APPS,type=bind \
    --mount src="$(pwd)/ssh",target=/opt/GRM/ssh,type=bind \
    steadfasterx/grm:X-<version>
~~~
3. Optional: Instead of specifying the env variables above on container creation you can also specify these in the file [custom.vars](custom.vars.example). That way you do not need to re-create the container if your server name changes or if you want to connect to multiple repo servers.
For this just add the following line after the last `--mount ...`:
  
`    --mount src="$(pwd)/custom.vars",target=/opt/GRM/custom.vars,type=bind \`

  
## start GRM

1. `docker start grm`
2. flavor:
     - **X**: GRM will directly start
     - **http**: Open your web browser and connect to: http://localhost:8085
