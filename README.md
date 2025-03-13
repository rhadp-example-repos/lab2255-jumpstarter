# lab2255-jumpstarter
Jumpstarter Lab setup (RH Summit 2025)

### Setup

First steps:

* Make a copy of file `inventory/main.example.yml` and name it `inventory/main.yml`.
* Update the `inventory/main.yml` file with the required values.

Run the following commands to install the required packages:

```shell
# prepare the automotive image builder host
ansible-playbook -i inventory 1_prepare_aib_host.yml
```

```shell
# patch the infrastructure / catalog item
ansible-playbook -i inventory 2_patch_ci.yml
```
```shell
# import the code templates
ansible-playbook -i inventory 3_import_repos.yml
```

```shell
# patch the developer hub setup
ansible-playbook -i inventory 4_patch_developer_hub.yml
```
