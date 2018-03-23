# frozen_string_literal: true

require 'spec_helper'

describe 'hazelcast' do
  context 'On a Debian 8' do
    let(:facts) do
      {
        os: {
          family: 'Debian',
          name: 'Debian',
          release: {
            major: '8',
          },
        },
      }
    end

    let(:params) do
      {
        root_dir: '/opt',
        config_dir: '/etc/hazelcast',
        version: '3.9.3',
        service_ensure: 'running',
        manage_user: true,
        user: 'hazelcast',
        group: 'hazelcast',
        download_url: 'http://hazelcast.com/download/download.jsp?version=3.9.3&format=tar&p28848',
        java: '/usr/bin/java',
        java_options: '-Xss256k -Xms64 -Xmx128 -Djvm_option=jvm_value -Dfoo=bar',
      }
    end

    describe 'Compile all the dependencies' do
      it { is_expected.to compile.with_all_deps }
    end

    describe 'Testing the dependencies among the classes' do
      it { is_expected.to contain_class('hazelcast::install') }
      it { is_expected.to contain_class('hazelcast::config') }
      it { is_expected.to contain_class('hazelcast::service') }
      it { is_expected.to contain_class('hazelcast::install').that_comes_before('Class[hazelcast::config]') }
      it { is_expected.to contain_class('hazelcast::service').that_subscribes_to('Class[hazelcast::config]') }
    end
  end

  context 'On a Debian 9' do
    let(:facts) do
      {
        os: {
          family: 'Debian',
          name: 'Debian',
          release: {
            major: '9',
          },
        },
      }
    end

    let(:params) do
      {
        root_dir: '/opt',
        config_dir: '/etc/hazelcast',
        version: '3.9.3',
        service_ensure: 'running',
        manage_user: true,
        user: 'hazelcast',
        group: 'hazelcast',
        download_url: 'http://hazelcast.com/download/download.jsp?version=3.9.3&format=tar&p28848',
        java: '/usr/bin/java',
        java_options: '-Xss256k -Xms64 -Xmx128 -Djvm_option=jvm_value -Dfoo=bar',
      }
    end

    describe 'Compile all the dependencies' do
      it { is_expected.to compile.with_all_deps }
    end

    describe 'Testing the dependencies among the classes' do
      it { is_expected.to contain_class('hazelcast::install') }
      it { is_expected.to contain_class('hazelcast::config') }
      it { is_expected.to contain_class('hazelcast::service') }
      it { is_expected.to contain_class('hazelcast::install').that_comes_before('Class[hazelcast::config]') }
      it { is_expected.to contain_class('hazelcast::service').that_subscribes_to('Class[hazelcast::config]') }
    end
  end

  context 'On a CentOS 7' do
    let(:facts) do
      {
        os: {
          family: 'RedHat',
          name: 'CentOS',
          release: {
            major: '7',
          },
        },
      }
    end

    let(:params) do
      {
        root_dir: '/opt',
        config_dir: '/etc/hazelcast',
        version: '3.9.3',
        service_ensure: 'running',
        manage_user: true,
        user: 'hazelcast',
        group: 'hazelcast',
        download_url: 'http://hazelcast.com/download/download.jsp?version=3.9.3&format=tar&p28848',
        java: '/usr/bin/java',
        java_options: '-Xss256k -Xms64 -Xmx128 -Djvm_option=jvm_value -Dfoo=bar',
      }
    end

    describe 'Compile all the dependencies' do
      it { is_expected.to compile.with_all_deps }
    end

    describe 'Testing the dependencies among the classes' do
      it { is_expected.to contain_class('hazelcast::install') }
      it { is_expected.to contain_class('hazelcast::config') }
      it { is_expected.to contain_class('hazelcast::service') }
      it { is_expected.to contain_class('hazelcast::install').that_comes_before('Class[hazelcast::config]') }
      it { is_expected.to contain_class('hazelcast::service').that_subscribes_to('Class[hazelcast::config]') }
    end
  end

  context 'On a RedHat 7' do
    let(:facts) do
      {
        os: {
          family: 'RedHat',
          name: 'RedHat',
          release: {
            major: '7',
          },
        },
      }
    end

    let(:params) do
      {
        root_dir: '/opt',
        config_dir: '/etc/hazelcast',
        version: '3.9.3',
        service_ensure: 'running',
        manage_user: true,
        user: 'hazelcast',
        group: 'hazelcast',
        download_url: 'http://hazelcast.com/download/download.jsp?version=3.9.3&format=tar&p28848',
        java: '/usr/bin/java',
        java_options: '-Xss256k -Xms64 -Xmx128 -Djvm_option=jvm_value -Dfoo=bar',
      }
    end

    describe 'Compile all the dependencies' do
      it { is_expected.to compile.with_all_deps }
    end

    describe 'Testing the dependencies among the classes' do
      it { is_expected.to contain_class('hazelcast::install') }
      it { is_expected.to contain_class('hazelcast::config') }
      it { is_expected.to contain_class('hazelcast::service') }
      it { is_expected.to contain_class('hazelcast::install').that_comes_before('Class[hazelcast::config]') }
      it { is_expected.to contain_class('hazelcast::service').that_subscribes_to('Class[hazelcast::config]') }
    end
  end
end
