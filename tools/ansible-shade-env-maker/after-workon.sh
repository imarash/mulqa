#!/usr/bin/bash
if [[ "$VIRTUAL_ENV" != "" ]]
then
    pip install ansible
    pip install os-client-config==1.20.0
else
    echo "You should be in a virtual environment to be able to run this."
    echo "Check first-make.sh"
fi

