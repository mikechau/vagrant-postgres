# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define 'postgres-dev', primary: true do |v|
    v.vm.network 'private_network', ip: '12.12.12.12'

    v.vm.network 'forwarded_port', guest: 5432, host: 5432, auto_correct: true

    v.vm.provider 'virtualbox' do |vb|
      vb.name = 'postgres-dev'
      vb.customize ['modifyvm', :id, '--vram', '10']
      vb.customize ['modifyvm', :id, '--cpuexecutioncap', '80']
      vb.customize ['modifyvm', :id, '--memory', '512']
      vb.customize ['modifyvm', :id, '--cpus', '1']
    end

    v.vm.provision :ansible do |ansible|
      ansible.limit = 'all'
      ansible.inventory_path = File.expand_path('inventories/dev', __dir__)
      ansible.playbook = File.expand_path('provision.yml', __dir__)
      ansible.verbose = 'vv'
    end
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
  end
end
