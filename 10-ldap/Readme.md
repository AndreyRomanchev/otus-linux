Instruction
```
setup FreeIPA server
ansible-playbook ldap.yml
```

SSH-keys authorization
```
ssh-keygen -t rsa -C bytamine@dispostable.com
ipa user-mod admin --sshpubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgryBof95fB/tHU61NN5UZn4WpRigbGhaMj88KZQYGBZeBcHox9xGFoLU4SfEyBXmvMh7A1witopqEUSEWSKBwH7v4bT4VHaVv9gSsPiWKXj/uUNglHQQtYpD5+3RYThGEZFgA5MfalfyXR8KM82SEWBbHC3WCsXDVPsa+w4/6OhnqL1YwHGFOXCeVsz8DUtxK3VRMy7CMH2ms0iLjSCejUW9v6YOzNeDIo6S12nV9UInpGgM+oC9EzwqodB6BmU60yJyODFsqvnIfX+r/dLkW4R+W3oytTuDWWrRwB9WojL0PVKSfBadj6gBJs6BCOsXofpoh1IaikcRtsoINJUFZ bytamine@dispostable.com"
```
