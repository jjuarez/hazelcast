# frozen_string_literal: true

require 'spec_helper'

describe 'hazelcast' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with parameters' do
        it { is_expected.to compile.with_all_deps }

        describe 'by default' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('hazelcast') }
          it { is_expected.to contain_class('hazelcast::config') }
          it { is_expected.to contain_file('/etc/hazelcast').with('ensure' => 'directory') }
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast.conf') } # TODO: install on the distro recomendations
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast.xml') }
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast-client.xml') }

          it { is_expected.to contain_class('hazelcast::install') }
          it { is_expected.to contain_group('hazelcast') }
          it { is_expected.to contain_user('hazelcast').with('gid' => 'hazelcast') }
          it { is_expected.to contain_archive('/tmp/hazelcast-3.9.4.tar.gz') }
          it {
            is_expected.to contain_file('/opt/hazelcast-3.9.4')
              .with(ensure: 'directory',
                    owner:  'hazelcast',
                    group:  'hazelcast',
                    mode:   '0750')
          }

          it {
            is_expected.to contain_file('/opt/hazelcast-3.9.4/bin/hazelcast-cli.sh')
              .with(ensure: 'present',
                    owner:  'hazelcast',
                    group:  'hazelcast',
                    mode:   '0750')
          }

          it { is_expected.to contain_file('/opt/hazelcast').with(ensure: 'link') }

          if ['centos-7-x86_64', 'debian-8-x86_64', 'debian-9-x86_64', 'redhat-7-x86_64', 'ubuntu-16.04-x86_64', 'ubuntu-18.04-x86_64', 'ubuntu-18.10-x86_64'].include?(os)
            it {
              is_expected.to contain_file('/etc/systemd/system/hazelcast-server.service')
                .with(ensure: 'present',
                      owner:  'root',
                      group:  'root',
                      mode:   '0644')
            }

            it {
              is_expected.to contain_service('hazelcast-server')
                .with(ensure: 'running',
                      hasrestart: true,
                      hasstatus: true)
            }

            it {
              is_expected.to contain_service('hazelcast-server')
                .that_subscribes_to('File[/etc/hazelcast/hazelcast.xml]')
            }
          end
        end
      end

      context 'with parameters' do
        let(:params) do
          {
            version: '3.9.3',
            root_dir: '/opt',
            config_dir: '/etc/hazelcast',
            service_ensure: 'running',
            manage_user: true,
            user: 'hz',
            group: 'hz',
            download_url: 'http://hazelcast.com/download/download.jsp?version=3.9.4&format=tar',
            java: '/usr/bin/java',
            java_options: '-Xss256k -Xms64 -Xmx128 -Djvm_option=jvm_value -Dfoo=bar',
            classpath: ['superawesome-lib-1.0.0.jar', 'anothercrack-lib-0.1.0.jar'],
            group_name: 'hzgroup',
            group_password: 'hzpass',
            cluster_members: ['node-dev-001.example.org', 'node-dev-002.example.org'],
          }
        end

        describe 'specific' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('hazelcast') }
          it { is_expected.to contain_class('hazelcast::config') }
          it { is_expected.to contain_file('/etc/hazelcast').with('ensure' => 'directory') }
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast.conf') } # TODO: install on the distro recomendations
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast.xml') }
          it { is_expected.to contain_file('/etc/hazelcast/hazelcast-client.xml') }

          it { is_expected.to contain_class('hazelcast::install') }
          it { is_expected.to contain_group('hz') }
          it { is_expected.to contain_user('hz').with('gid' => 'hz') }
          it { is_expected.to contain_archive('/tmp/hazelcast-3.9.3.tar.gz') }
          it {
            is_expected.to contain_file('/opt/hazelcast-3.9.3')
              .with(ensure: 'directory',
                    owner:  'hz',
                    group:  'hz',
                    mode:   '0750')
          }

          it {
            is_expected.to contain_file('/opt/hazelcast-3.9.3/bin/hazelcast-cli.sh')
              .with(ensure: 'present',
                    owner:  'hz',
                    group:  'hz',
                    mode:   '0750')
          }

          it { is_expected.to contain_file('/opt/hazelcast').with(ensure: 'link') }

          if ['centos-7-x86_64', 'debian-8-x86_64', 'debian-9-x86_64', 'redhat-7-x86_64', 'ubuntu-16.04-x86_64', 'ubuntu-18.04-x86_64', 'ubuntu-18.10-x86_64'].include?(os)
            it {
              is_expected.to contain_file('/etc/systemd/system/hazelcast-server.service')
                .with(ensure: 'present',
                      owner:  'root',
                      group:  'root',
                      mode:   '0644')
            }
            it {
              is_expected.to contain_service('hazelcast-server')
                .with(ensure: 'running',
                      hasrestart: true,
                      hasstatus: true)
            }

            it {
              is_expected.to contain_service('hazelcast-server')
                .that_subscribes_to('File[/etc/hazelcast/hazelcast.xml]')
            }
          end
        end
      end
    end
  end
end
