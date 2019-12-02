docker build --build-arg USER=$USER . -t $(basename $PWD):latest
