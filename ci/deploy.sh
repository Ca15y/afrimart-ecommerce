#!/bin/bash
set -e

echo "Running Ansible deployment..."

cd ansible
ansible-playbook -i inventory/hosts playbooks/site.yml

