FROM fedora:latest

RUN dnf install -y vim

#Pathogen
RUN dnf install -y curl
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

# YouCompleteMe
RUN dnf install -y git
RUN cd ~/.vim/bundle; \
    git clone --recursive --depth=1 --branch=master https://github.com/ycm-core/YouCompleteMe.git;
RUN sudo dnf install -y cmake gcc-c++ make python3-devel
RUN cd ~/.vim/bundle/YouCompleteMe; \
    python3 install.py --clangd-completer

# Clang Format
RUN cd ~/.vim/bundle; \
      git clone --depth=1 --branch=master https://github.com/rhysd/vim-clang-format.git
RUN dnf install -y clang

# File Fuzzy Finder
RUN cd ~/.vim/bundle; \
      git clone --depth=1 --branch=master https://github.com/junegunn/fzf.vim.git;
RUN dnf install -y fzf ripgrep
RUN echo "export FZF_DEFAULT_COMMAND='rg --files --follow'" >> /etc/bashrc

# Snippets
RUN cd ~/.vim/bundle; \
      git clone --depth=1 --branch=master https://github.com/SirVer/ultisnips.git; \
      git clone --depth=1 --branch=master https://github.com/honza/vim-snippets.git;

ADD vimrc /root/.vimrc

# Run as a common user
ARG USER
RUN adduser $USER; usermod -a -G root $USER
WORKDIR /home/$USER
RUN ln -s /root/.vim
RUN ln -s /root/.vimrc
USER $USER

CMD vim
