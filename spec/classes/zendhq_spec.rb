# frozen_string_literal: true

require 'spec_helper'

describe 'zendhq' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      file_uri = 'puppet:///modules/test_module/licenses/test-license'
      let(:facts) { os_facts }

      describe 'always' do
        let(:params) { { license_source: file_uri } }

        it { is_expected.to compile }
        it { is_expected.to contain_class('zendhq').with_license_source(file_uri) }
        it { is_expected.to contain_class('zendhq::package') }
        it { is_expected.to contain_class('zendhq::service') }
        it { is_expected.to contain_class('zend_common::license').with_source(file_uri) }
      end

      describe 'installs epel-release on CentOS' do
        let(:params) { { license_source: file_uri } }

        if os_facts[:os]['name'] == 'CentOS'
          it { is_expected.to contain_package('epel-release') }
        end
      end

      describe 'with settings' do
        settings = { 'zendhq.daemon_uri': 'tcp://0.0.0.0:10090' }
        let(:params) { { license_source: file_uri, settings: settings } }

        it { is_expected.to contain_class('zendhq::config') }
      end
    end
  end
end
