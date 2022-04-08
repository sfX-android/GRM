# GRM
GRM - [G]rapheneOS [R]epo [M]anager

A graphical UI for managing a custom Apps [repository](https://github.com/GrapheneOS/apps.grapheneos.org) for [GrapheneOS](https://grapheneos.org/)


## IMPORTANT HINT

GRM is not related to the Graphene project in any way. It is just a personal project and comes without any guarantees ;)

_The GrapheneOS name and logo are trademarks of the [GrapheneOS](https://grapheneos.org/) project._

# Requirements

## Supported Operating Systems

While GRM runs on any Linux natively it can be used on any Operating System which supports [docker](https://www.docker.com), which means:

- Windows
- Linux
- Mac OS

## Apps Repository

You have to setup your repository like described in the Graphene OS README (currently available [here](https://github.com/steadfasterX/apps.grapheneos.org/blob/sfX-guide/README.md) until accepted [upstream](https://github.com/GrapheneOS/apps.grapheneos.org))

# Installation

## Linux

a one-liner ;) 

`git clone https://github.com/sfX-android/GRM.git /opt/GRM`

After that you will find a file `GRM.desktop` in `/opt/GRM/`. If you like you can install it: `cp GRM.desktop ~/.local/share/applications/`
(If you are using a different installation directory for GRM you obviously need to change `GRM.desktop` accordingly).

## Linux & docker: SSH keys

Create SSH keys for GRM to access your repository server. If your current Operating System is not Linux just do these commands on your repository server and scp or copy & paste the keys locally.

### Docker users only
1. create a directory for your GRM data, eg. name it "GRM"
2. create these subdirectories (exactly named like that) in "GRM":
    - `ssh` (you need to put the SSH keys here)
    - `apps` (all APKs in this directory will be available in GRM later)

### Linux & Docker users
1. Create a key named `GRM_ed25519` (this filename is fixed):
   <br/>`ssh-keygen -a 100 -t ed25519 -f GRM_ed25519`
   <br/>when prompted for a password simply press ENTER twice (required)
2. add `GRM_ed25519.pub` to your `./ssh/authorized_keys` on your repository server (GRM supports only ssh pub key auth)
3. put the SSH key files into the folder `ssh`
   - docker: `GRM/ssh` (see above)
   - Linux: `/opt/GRM/ssh`
4. verify that your SSH user can access your server without being prompted:
   - docker: _use a SSH client and add the GRM_ed25519 key there for authentication_
   - Linux: `ssh -i /opt/GRM/ssh/GRM_ed25519 <PUT-YOUR-USERNAME-HERE>@<PUT-YOUR-SSH-SERVER-HERE>`
5. if you see a hostkey verification prompt accept it but you should be logged in without specifying a password. If you get prompted for a password something is wrong in your setup which needs to be fixed first before you can proceed!
6. Create [custom.vars](custom.vars.example) (copy from `custom.vars.example`) in `/opt/GRM/` and setup at least your remote server details there

## Docker

Follow the [Docker guide](DOCKER.md) 

## start GRM

### Linux

`/opt/GRM/grm` (or using the Start menu of your fav distro and search for `GRM` if you installed the Desktop file)
