# Environment for TSPL course  
I personally recommend using it with vscode and its remote-container plugin.  
Image size could be a bit large (~3GB).   

To build and run:  
`docker run -it $(docker build . -f tspl.Dockerfile -q)`  
To test installation inside the container:  
`agda --compile hello-world.agda && ./hello-world`
- [ ] TODO: upload it to dockerhub.
- [ ] TODO: use multi-stage building to save some disk space.  
