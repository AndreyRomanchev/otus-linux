Instruction
```
vagrant up
ansible-playbook nginx.yml
curl http://192.168.11.150:8080
curl http://192.168.11.151:8080
```
Tests
```
cd nginx
molecule test
```
