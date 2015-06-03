require 'spec_helper'

module BinaryBuilder
  describe PHPArchitect do
    subject(:architect) { PHPArchitect.new(binary_version: binary_version) }

    context 'when building any php interpreter and modules' do
      let(:binary_version) { '5.6.9' }

      describe 'blueprint' do
        it 'adds the BINARY_VERSION value' do
          expect(architect.blueprint).to include 'PHP_VERSION=5.6.9'
        end

        it 'adds the ZTS_VERSION value' do
          expect(architect.blueprint).to include 'ZTS_VERSION=20131226'
        end

        it 'adds the RABBITMQ_C_VERSION value' do
          expect(architect.blueprint).to include 'RABBITMQ_C_VERSION=0.5.2'
        end

        it 'adds the HIREDIS_VERSION value' do
          expect(architect.blueprint).to include 'HIREDIS_VERSION=0.11.0'
        end

        it 'adds the LUA_VERSION value' do
          expect(architect.blueprint).to include 'LUA_VERSION=5.2.4'
        end

        it 'adds the module version values' do
          expect(architect.blueprint).to include %q{MODULES[amqp]="1.4.0"}
        end
      end
    end

    context 'when building php 5.4' do
      let(:binary_version) { '5.4.41' }

      describe 'blueprint' do
        it 'does not include the zendopcache as a package_php_extension because the *.so is opcache.so' do
          expect(architect.blueprint).to_not include 'package_php_extension "zendopcache"'
          expect(architect.blueprint).to include 'package_php_extension "opcache"'
        end
      end
    end
  end
end
