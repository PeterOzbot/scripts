# scripts
Admin and other helper scripts

# Node

package.json :
```
{
  "name": "hello-world",
  "version": "1.0.0",
  "description": "hello-world cli client",
  "bin": "index.js"
}
```

The executable script i.e index.js should starts with a line "#!/usr/bin/env node"

## If nvm installed + node 16.x.x

### Pack/install :

nvm use 16

npm pack

npm install -g rename-files-yt1s-1.0.0.tgz

### Run 

Auto-complete will work only if node is set to 16: nvm use 16. 