#!/bin/bash

Major=0
Minor=0
Patch=0
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
