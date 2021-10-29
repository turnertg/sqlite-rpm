# sqlite-rpm
Dockerfile to build sqlite rpm and dependencies against RockyLinux's sources

Build with something along the lines of `sudo docker build --network=dlan -f Dockerfile . --build-arg="TCL_VER=8.6.8-2" --build-arg="SQLITE_VER=3.26.0-13" --no-cache`

Will revise with longer readme later.
