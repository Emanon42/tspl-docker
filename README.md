# Environment for TSPL course  

I personally recommend using it with vscode and its remote-container plugin.  
Image size could be a bit large (~4GB).   

## Getting started

To build: 
```
docker build . -f tspl.Dockerfile
docker image tag $DOCKER_IMG_ID emagda
```

To run: 
```
docker run --name plfa -d -t -v ~/Documents/tspl/plfa:/plfa emagda
```

To test installation inside the container:  
```
docker exec -t -i plfa /bin/bash
agda --compile hello-world.agda && ./hello-world
```

## TODO

- [ ] TODO: upload it to dockerhub.
- [ ] TODO: use multi-stage building to save some disk space.  
