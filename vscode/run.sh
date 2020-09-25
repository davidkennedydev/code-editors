# set SELINUX to permissive mode and enable X11 forwarding
sudo setenforce 0 || true

docker run --rm -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:Z --net host $(basename $PWD)

# set SELINUX to enforcing
sudo setenforce 1 || true
