#!/bin/bash


old_tag_id=$(git rev-list --tags --max-count=1)
echo $(git tag)

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

version_update_flag="y"
if [[ "$version_update_flag" == "y" ]]
then
    Major_update_flag="y"
    Minor_update_flag="y"

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
    git push origin $Tag
fi
