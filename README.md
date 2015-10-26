# vagrant-postgres

This is a Vagrant virtual machine to provide a convenient way to run Postgres without needing to install it on your machine locally.

By default it is using Ubuntu 14.04 LTS and Postgres 9.4.

It is provisioned with Ansible.

## Setup

```
./scripts/galaxy_install.sh

vagrant up
```

## Credentials

```
username: vagrant
password: dev

ips: 12.12.12.12, localhost
port: 5432
```

## Testing

```
# Install gems
bundle install

# Run tests
rake
```

## LICENSE

MIT

