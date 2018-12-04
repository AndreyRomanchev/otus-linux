import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

print("testinfra_hosts =", testinfra_hosts)
host = 'instance'


def test_nginx_server_is_installed(host):
    nginx = host.package('nginx')

    assert nginx.is_installed


def test_nginx_is_running(host):
    nginx = host.service('nginx')

    assert nginx.is_running
    assert nginx.is_enabled


def test_nginx_port_is_8080(host):

    assert host.socket("tcp://8080").is_listening
