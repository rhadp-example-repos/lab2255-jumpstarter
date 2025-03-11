# lab2255-jumpstarter
Jumpstarter Lab setup (RH Summit 2025)

```shell
# patch the backstage setup
ansible-playbook -i inventory 1_patch_backstage.yml
```

```shell
# prepare the image builder
ansible-playbook -i inventory 2_prepare_builder.yml
```
