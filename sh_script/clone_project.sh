#!/bin/sh

echo "Please enter name of project [projectname.dev]: "
read projectname

RELEASESFOLDER=$projectname/releases
RELEASEDATE=`date "+%Y-%m-%d-%H%M"`
TARGETSYMLINK=$projectname/current

if [ -d "$projectname" ]; then

    echo "Please enter git reference [https://username@bitbucket.org/username/projectname.git]: "
    read gitreference

    if [ "$projectname" != "" -a "$gitreference" != "" ]; then 
        git clone $gitreference $RELEASESFOLDER/$RELEASEDATE
        wait
        if [ ! -f $TARGETSYMLINK ]; then
            ln -sf releases/$RELEASEDATE $projectname/current
        else
            rm -R $projectname/current && ln -sf releases/$RELEASEDATE $projectname/current
        fi
        echo "SUCCESS: Project cloned successfully."
    else 
        echo "ERROR: Git reference is required. Exiting now."
    fi
else
    echo "ERROR: Directory does not exist. Exiting now."
fi