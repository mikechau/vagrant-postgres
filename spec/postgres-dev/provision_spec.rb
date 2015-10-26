require 'spec_helper'

describe 'Ubuntu 14.04 LTS', if: os[:family] == 'ubuntu' do
  context 'role: ANXS.postgres' do
    it 'installed postgresql-9.4' do
      expect(package('postgresql-9.4')).to be_installed
    end

    it 'created a user' do
      cmd = command(%Q|psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='vagrant'" -U postgres|)
      expect(cmd.stdout.chomp).to eq "1"
    end

    context 'enabled extensions' do
      it 'includes hstore' do
        cmd = command(%Q|psql -t -A -c "select count(*) from pg_extension where extname = 'hstore'" -U vagrant|)
        expect(cmd.stdout.chomp).to eq "1"
      end

      it 'includes uuid_ossp' do
        cmd = command(%Q|psql -t -A -c "select count(*) from pg_extension where extname = 'uuid-ossp'" -U vagrant|)
        expect(cmd.stdout.chomp).to eq "1"
      end

      it 'includes citext' do
        cmd = command(%Q|psql -t -A -c "select count(*) from pg_extension where extname = 'citext'" -U vagrant|)
        expect(cmd.stdout.chomp).to eq "1"
      end
    end

    it 'installed libpq-dev' do
      expect(package('libpq-dev')).to be_installed
    end

    it 'installed python-psycopg2' do
      expect(package('python-psycopg2')).to be_installed
    end

    context 'service' do
      it 'is enabled' do
        expect(service('postgresql')).to be_enabled
      end

      it 'is running' do
        expect(service('postgresql')).to be_running
      end
    end

    context 'ports' do
      it 'is listening on 5432' do
        expect(port(5432)).to be_listening
      end
    end
  end
end
