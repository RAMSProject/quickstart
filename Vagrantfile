# -*- mode: ruby -*-

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    # setup a public network for Vagrant
    # i.e. the VM will act as though it's another machine on your internal network
    # this is insecure because it exposes this machine to the entire world, however,
    # if you're behind a firewall it's like running this machine on a computer behind the firewall.
    #
    # IMPORTANT NOTE: We switched from the default NAT+port forwarding because
    # Virtualbox's port forwarding has some serious bugs in it that interact badly with Docker.
    # Do not use port forwarding to access applications running inside the
    # Vagrant VM (especially Docker containers)
    #
    # This is discussed here:
    # https://github.com/boot2docker/boot2docker-cli/issues/164
    # https://groups.google.com/forum/#!topic/docker-user/bvZdFqQnUK8 <-- we were experiencing this content-length error
    #
    config.vm.network "public_network", type: "dhcp"


    # Share the root folder into the host OS.
    # this uses vboxfs to share stuff. it's stable, but slow as hell on windows.
    # fortunately with Docker, we're not doing too much in the shared folder
    config.vm.synced_folder ".", "/home/vagrant/docker"
    # end

    #
    # No good can come from updating plugins.
    # Plus, this makes creating Vagrant instances MUCH faster
    #
    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end

    #
    # This is the most amazing module ever, it caches anything you download with apt-get!
    # To install it: vagrant plugin install vagrant-cachier
    #
    if Vagrant.has_plugin?("vagrant-cachier")
        # Configure cached packages to be shared between instances of the same base box.
        # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
        config.cache.scope = :box
    end

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end

    # create a way for us to know if we're running inside vagrant on windows
    # from within the guest OS.
    config.vm.provision :shell do |shell|
        shell_cmd = ""
        if Vagrant::Util::Platform.windows?
            shell_cmd << "echo 'YES' > /etc/is_running_vagrant_on_windows"
        end
        shell.inline = "#{shell_cmd}"
    end
    
    config.vm.provision :shell, :path => "vagrant/vagrant.sh"

    config.vm.provider :virtualbox do |vb|
        # allow symlinks to be created in /home/vagrant/uber
        # modify "home_vagrant_uber" to be different if you change the path.
        # NOTE: requires Vagrant to be run as administrator for this to work.
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/home_vagrant_uber", "1"]
    end
end
