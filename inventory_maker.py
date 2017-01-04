#!/usr/bin/env python

# Dynamic inventory maker for all instances and nodes of openstack
# After running you should find a hosts file in the same folder as this script with updated data
# Created by: Arash Morattab

from shade import *
import subprocess
import json

#simple_logging(debug=True)
conn = openstack_cloud()

inventory_groups = ['web_server', 'app_server', 'db_server']
openstack_inventory_groups = ['compute', 'scheduler', 'network', 'consoleauth']

f = open('hosts', 'w')

instances = conn.list_servers()

for instance in instances:
    print(instance.toYAML())

inventory = dict()
instance_ips = []

# Make instance groups based on their name
for inv_group in inventory_groups:
    inventory[inv_group] = list()
    f.write('[instances-'+ inv_group + ']' + '\n')
    for instance in instances:
        if instance.name == inv_group:
            inventory[inv_group].append(instance)
            if instance.interface_ip is not '':
                f.write(instance.interface_ip+'\n')
                instance_ips.append(instance.interface_ip)
    f.write('\n')           

# Make all instances  group
f.write('[instances-all]' + '\n')
for ip in instance_ips:
    f.write(ip+'\n')
f.write('\n')           


# Make openstack nodes groups
#openstack host list --format value

openstack_hosts = json.loads(subprocess.check_output(["openstack", "host" , "list", "--format", "json"]))

for inv_group in openstack_inventory_groups:
    inventory[inv_group] = list()
    f.write('[openstack-'+ inv_group + ']' + '\n')
    for host in openstack_hosts:
        if host['Service'] == inv_group:
#            inventory[inv_group].append(instance)
            if host['Host Name'] is not '':
                f.write(host['Host Name']+'\n')
    f.write('\n')           

f.close()
