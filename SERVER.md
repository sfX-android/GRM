## Server setup

The following describes the procedure to create a custom apps repository running on your own server which then can be managed by [GRM](https://github.com/sfX-android/GRM).

### Prerequisites

1. a system with:
    - python3
    - signify(-openbsd)
    - a webserver (e.g. nginx)
    - aapt
2. ideally a FQDN (while IP is possible but not recommended for well known reasons)
3. a SSL certificate (recommended: Let's Encrypt)

### Initial Setup

1. Create your own signing key: `signify -n -G -p apps.0.pub -s apps.0.sec`

2. clone this repository to your server (e.g. `git clone https://github.com/sfX-Android/apps.grapheneos.org /var/www/html/`). note: if you do NOT plan to use GRM you can use the official one instead but for GRM you have to go with this one.

3. Create the following directories in this cloned directory: `mkdir apps apps-stable apps-beta`

4. install a webserver on your server and ensure it has a valid certificate set (see step 3)
    - the root directory must point to the `apps` directory (e.g. `/var/www/html/apps`)

5. put your app(s) in the `apps` directory 
    - every app must have its own directory (i.e. `apps/packages/<app-package-name>/<versionCode>/my-app.apk`)
    - you can use `grm-import.py` to achieve all that which is also used by [GRM](https://github.com/sfX-android/GRM) itself

6. run `./generate2.py` to sign and add these apps to your repo

7. modify the Apps app:
    - replace all occurences of `apps.grapheneos.org` with your own FQDN
    - grab the content of your public key from `apps.0.pub` and replace the `REPO_PUBLIC_KEY` variable in [build.gradle.kts](https://github.com/GrapheneOS/Apps/blob/main/app/build.gradle.kts)
    - in that same file ensure `REPO_BASE_URL` is set correctly
    - adjust [network_security_config.xml](https://github.com/GrapheneOS/Apps/blob/main/app/src/main/res/xml/network_security_config.xml) if your CA is not already there
    
8. build the Apps app

### Updating your repo

Follow steps 5 + 6

