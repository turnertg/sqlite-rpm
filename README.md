# sqlite-rpm
Dockerfile to build sqlite rpm and dependencies against RockyLinux's spec/srpm, but for CentOS 7 (and other rhel7 based distros).

Build with something along the lines of `sudo docker build --network=dlan -f Dockerfile . --build-arg="TCL_VER=8.6.8-2" --build-arg="SQLITE_VER=3.26.0-13" --no-cache`

**DO NOT BUILD ON BTRFS, SEE BELOW MAILING LIST THREADS**
- https://www.mail-archive.com/sqlite-users@mailinglists.sqlite.org/msg118235.html
- https://www.mail-archive.com/sqlite-users@mailinglists.sqlite.org/msg108814.html

Will revise with longer readme later.
