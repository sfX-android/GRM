#!/bin/bash
########################################################
#
# cleanup all apps to fix broken ones
#
########################################################
DEBUG=0
APPSDIR=temp-apps
[ $DEBUG -eq 1 ] && APPSDIR=apps-stable && echo "DEBUG MODE! NO ACTION WILL BE TAKEN!"

cd /var/www/html

# cleanup older broken apps first
[ -d "$APPSDIR" ] && [ $DEBUG -ne 1 ] && rm -rf $APPSDIR

# move current apps to a temp dir & re-create stable dir
[ $DEBUG -ne 1 ] && mv apps-stable $APPSDIR && mkdir apps-stable
[ $? -ne 0 ] && [ $DEBUG -ne 1 ] && echo "ERROR: Cannot create or move apps-stable dir!" && exit 3

# re-generate one by one the metadata to find the broken app, then remove it
for a in $(find $APPSDIR -type f);do
    echo "pls be patient, adding $a to repo..."
    [ $DEBUG -ne 1 ] && cp $a stable-apps && ./generate.py
    if [ $? -ne 0 ];then
        if [ $DEBUG -ne 1 ];then 
            rm $a
            echo -e "\nproblematic app found:\n\n\t>$a<\n\nThis app has been removed, pls re-run this script to continue!\n"
            rm -rf apps-stable
            mv $APPSDIR apps-stable
            exit 3
        fi
    fi
done

[ $DEBUG -eq 1 ] && echo "DEBUG MODE! NO ACTION HAS BEEN TAKEN!"
echo "script finished."
