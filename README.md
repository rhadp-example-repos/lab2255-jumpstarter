# lab2255-jumpstarter
Jumpstarter Lab setup (RH Summit 2025)

```shell
# patch the infrastructure / catalog item
ansible-playbook -i inventory 1_patch_ci.yml
```

```shell
# patch the backstage setup
ansible-playbook -i inventory 10_patch_backstage.yml
```

```shell
# prepare the image builder
ansible-playbook -i inventory 20_prepare_builder.yml
```
