#!/bin/sh

echo "Please enter project name (for multiple seperate by white space) [projectname.dev] or [projectname1.dev projectname2.dev ...]: "
read projectnames

RELEASEDATE=`date "+%Y%m%d%H%M"`

if [ "$projectnames" != "" ]; then 
	for projectname in $projectnames
	do 
		mkdir $projectname
	    mkdir $projectname/releases
	    mkdir $projectname/shared
        mkdir $projectname/releases/$RELEASEDATE
        mkdir $projectname/releases/$RELEASEDATE/sql
        mkdir $projectname/releases/$RELEASEDATE/web
        mkdir $projectname/releases/$RELEASEDATE/shared
        ln -sf releases/$RELEASEDATE/web $projectname/current
        ln -sf releases/$RELEASEDATE $projectname/core
        ln -sf releases/$RELEASEDATE/sql $projectname/sql
	done

    echo "Project $projectname has been created. Exiting now."
else 
    echo "You have not enter any project name. Exiting now."
fi