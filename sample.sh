#!/bin/bash

# Redirect output to stderr.
exec 1>&2
# enable user input
exec < /dev/tty

old_tag_id=$(git rev-list --tags --max-count=1)

if [[ "$old_tag_id" == "" ]]
then
        Major=0
        Minor=0
        Patch=0
else
        old_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
        Major=$(echo $old_tag | cut -d '.' -f1 | awk '{print substr($0, 2)}' )
        Minor=$(echo $old_tag | cut -d '.' -f2 )
        Patch=$(echo $old_tag | cut -d '.' -f3 )
        echo $Major
        echo $Minor
        echo $Patch
fi

echo "Version change required(y/n): "
read version_update_flag
if [[ "$version_update_flag" == "y" ]]
then
    echo "Breaking change(y/n): "
    read Major_update_flag
    echo "Functionality update(y/n): "
    read Minor_update_flag

    if [[ "$Major_update_flag" == "y" ]]
    then
            Major=$((Major+1))
            Minor=0
            Patch=0
    elif [[ "$Minor_update_flag" == "y" ]]
    then
            Minor=$((Minor+1))
            Patch=0
    else
            Patch=$((Patch+1))
    fi

    Tag="v$Major.$Minor.$Patch"

    git tag $Tag
    echo "use git push --tags to push the tags to github"
fi