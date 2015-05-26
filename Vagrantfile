# -*- mode: ruby -*-

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.network :forwarded_port, guest: 8282, host: 8282
    config.vm.network :forwarded_port, guest: 80, host: 8000
    config.vm.network :forwarded_port, guest: 4443, host: 4443

    # uncomment for private network 
    # (useful if doing SMB or NFS shares FROM the guest OS -to- host OS
    # config.vm.network "private_network", type: "dhcp"

    # uncomment to enable SMB filesharing which is WAY faster than
    # Virtualbox's shared folders which are SLOOOOOOOOOOOOOOOOW.
    # note: symlinks don't work then.
    # note2: SMB is also kind of unstable, so probably don't use it.
    #
    # if Vagrant::Util::Platform.windows?
    #    config.vm.synced_folder ".", "/home/vagrant/uber", type: "smb"
    # else
    # non-SMB share VBOXfs (stable, but slow as hell)
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