## UNION

1. Run the follwing command:
```bash
wget -O docker-start.sh https://raw.githubusercontent.com/techxnode/guide-nodes/main/union/docker-start.sh && chmod +x docker-start.sh && sh docker-start.sh
```
2. Check log:
```bash
docker logs -f --tail 100 union-node
```
3. Check status:
```bash
docker inspect --format '{{.State.Status}}' union-node
```

### Common env: 
```bash
export KEY_NAME=<node-name>
```

### Create a New Account
```bash
uniond keys add $KEY_NAME
```

### Recover an Existing Account
```bash
uniond keys add $KEY_NAME --recover
```

### Finding your Union Address
```bash
uniond keys show $KEY_NAME --address
```

### Finding your Validator Address
```bash
uniond keys show $KEY_NAME --bech=val --address
```
