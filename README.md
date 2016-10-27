vagrant-ansible-ezpublish compatible window 10
=========================

http://jeremybarthe.com/2015/02/02/speed-up-vagrant-environment-symfony2/

vagrant plugin install vagrant-cachier

+ ajouter ça dans la config :

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine

    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }

    config.cache.enable :generic, {
      "cache"  => { cache_dir: "/var/www/app/cache" },
      "logs"   => { cache_dir: "/var/www/app/logs" },
      "vendor" => { cache_dir: "/var/www/vendor" },
    }
  end
  
vagrant reload

Essayer d'autre types de filesystem pour lenteurs windows :
https://www.vagrantup.com/docs/synced-folders/rsync.html
https://www.vagrantup.com/docs/synced-folders/smb.html


## Authors

- [Srdjan Vranac]
- [Dinko Korunic]
- [Edi Modric]

## Prerequisites

You need to have following installed:
- [Vagrant]
- [Ansible]
- [VirtualBox]

If you are running **Windows** (with or without SSD), or **Linux/Mac OS X with SSD** , copy or symlink `Vagrantfile-nfs` to `Vagrantfile`.

If you are running **Linux/Mac OS X without SSD**, copy `Vagrantfile-reverse-nfs` to `Vagrantfile`.

***DO NOT COMMIT THE `Vagrantfile`***.

Notice that **V** in `Vagrantfile` is **case sensitive**.

## Local development setup

The local development is meant to be used in a vagrant provisioned box.

The provisioner for the project is ansible.

Once you have the prerequisites setup, you can run the
```
vagrant up
```

from you terminal to start the process up.

If you do not see an error message, go get yourself a cup of coffee or your favorite beverage,
you deserve it.

If you start seeing the connection timeout after adding of the private key
```
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection timeout. Retrying...
    default: Warning: Connection timeout. Retrying...
```
You should open up the Virtualbox, click the vm running (name should be along the lines of netgen....)
and reset it (on OSX it is cmd+t). This is due to some weird bug somewhere on intersection of vagrant, virtualbox and
this ubuntu cloud image.
After the initial virtual machine build, you will not need to use this.

***IMPORTANT***

If vagrant starts complaining about locale and crashes the provisioning, in
/etc/ssh/ssh_config (or equivalent) comment out
```
SendEnv LANG LC_*
```

## Installing eZ Platform

Read the [step by step guide](EZPLATFORM_INSTALL.md) on how to install eZ Platform inside the box:

## Access via web browser

You can access whatever site you installed inside the box with the following URL in your browser: `http://172.21.12.10`

## Windows Support

Shell script will run from within the vm to provision the setup

## Deploying to remote servers

```
ansible-playbook -i provisioning/inventories/production provisioning/production.yml -u ubuntu --sudo
```

[Vagrant]: http://www.vagrantup.com/downloads.html
[Ansible]: http://docs.ansible.com/intro_installation.html
[VirtualBox]: https://www.virtualbox.org/wiki/Downloads
[Srdjan Vranac]: https://github.com/vranac
[Dinko Korunic]: https://github.com/dkorunic
[Edi Modric]: https://github.com/emodric
