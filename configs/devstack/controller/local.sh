#!/usr/bin/env bash

# Sample ``local.sh`` for user-configurable tasks to run automatically
# at the successful conclusion of ``stack.sh``.

# NOTE: Copy this file to the root DevStack directory for it to work properly.

# This is a collection of some of the things we have found to be useful to run
# after ``stack.sh`` to tweak the OpenStack configuration that DevStack produces.
# These should be considered as samples and are unsupported DevStack code.


# Keep track of the DevStack directory
TOP_DIR=$(cd $(dirname "$0") && pwd)

# Import common functions
source $TOP_DIR/functions

# Use openrc + stackrc + localrc for settings
source $TOP_DIR/stackrc

# Destination path for installation ``DEST``
DEST=${DEST:-/opt/stack}

if is_service_enabled nova; then

    # Import ssh keys
    # ---------------

    # Import keys from the current user into the admin OpenStack user

    # Get OpenStack user auth
    source $TOP_DIR/openrc admin admin

    # Add first keypair found in localhost:$HOME/.ssh
#    for i in $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_dsa.pub; do
#        if [[ -r $i ]]; then
#            nova keypair-add --pub_key=$i mykey
#            break
#        fi
#    done

    openstack keypair create mykey --public-key ~/.ssh/id_rsa.pub

    # Create Images
    # -------------

    if [ ! -f ~/trusty-server-cloudimg-i386-disk1.img ]; then
        wget http://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-i386-disk1.img -O ~/trusty-server-cloudimg-i386-disk1.img
    fi
    openstack image create --disk-format qcow2 --container-format bare \
          --public --file ~/trusty-server-cloudimg-i386-disk1.img \
             ubuntu-trusty-server

    if [ ! -f ~/CentOS-7-x86_64-GenericCloud.qcow2 ]; then
        wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2 -O ~/CentOS-7-x86_64-GenericCloud.qcow2
    fi
    openstack image create --disk-format qcow2 --container-format bare \
          --public --file ~/CentOS-7-x86_64-GenericCloud.qcow2 \
             centos-7 

    # Create A Flavor
    # ---------------

    # Get OpenStack admin auth
#    source $TOP_DIR/openrc admin admin

    # Name of new flavor
    # set in ``local.conf`` with ``DEFAULT_INSTANCE_TYPE=m1.micro``
#    MI_NAME=m1.micro

    # Create micro flavor if not present
#    if [[ -z $(nova flavor-list | grep $MI_NAME) ]]; then
#        nova flavor-create $MI_NAME 6 128 0 1
#    fi


    # Other Uses
    # ----------

    # Add tcp/22 and icmp to default security group
    nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
    nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0


    ## Create the MULQA nodes


    ## Create the Web Stack

    openstack stack create -t ~/mulqa/usecases/3tier-web-application/WebAppAutoScaling.yaml \
	--parameter "ssh_key_name=mykey" \
	--parameter "image_id=ubuntu-trusty-server" \
	--parameter "public_network_id=public" \
	autoscaleweb

fi
