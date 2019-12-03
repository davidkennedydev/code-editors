FROM fedora:latest

RUN dnf install -y curl; \
    curl -o vscode.rpm -L https://vscode-update.azurewebsites.net/latest/linux-rpm-x64/stable; \
    dnf install -y vscode.rpm; \
    rm vscode.rpm
RUN dnf install -y libX11-xcb;

ARG USER
# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/$USER && \
    echo "$USER:x:${uid}:${gid}:Developer,,,:/home/$USER:/bin/bash" >> /etc/passwd && \
    echo "$USER:x:${uid}:" >> /etc/group && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    chown ${uid}:${gid} -R /home/$USER

USER $USER
ENV HOME /home/$USER
CMD code --wait
