FROM fedora:latest as system_package_dependencies

RUN dnf install -y   \
      clang          \
      cmake          \
      curl           \
      fzf            \
      gcc-c++        \
      git            \
      make           \
      python3-devel  \
      ripgrep        \
      vim            \
    ;echo "System dependencies installed"

FROM system_package_dependencies as vim_plugins_init

RUN groupadd --system userland \
      && useradd -m --system --group userland nonroot

USER nonroot
ENV HOME /home/nonroot
WORKDIR /home/nonroot

ENV VIM_PLUGINS_AUTOSTARTED_PATH $HOME/.vim/pack/plugins/start

RUN mkdir -p $VIM_PLUGINS_AUTOSTARTED_PATH && cd $VIM_PLUGINS_AUTOSTARTED_PATH; \
      git clone --depth=1 --branch=master https://github.com/SirVer/ultisnips.git; \
      git clone --depth=1 --branch=master https://github.com/honza/vim-snippets.git; \
      git clone --recursive --depth=1 --branch=master https://github.com/ycm-core/YouCompleteMe.git; \
      git clone --depth=1 --branch=master https://github.com/rhysd/vim-clang-format.git; \
      git clone --depth=1 --branch=master https://github.com/junegunn/fzf.git; \
      git clone --depth=1 --branch=master https://github.com/junegunn/fzf.vim.git; \
    echo "Plugins cloned on the proper vim path"

FROM vim_plugins_init as vim_plugins

# Configure YouCompleteMe
RUN cd $VIM_PLUGINS_AUTOSTARTED_PATH/YouCompleteMe; \
    python3 install.py --clangd-completer

USER root

# Configure File Fuzzy Finder
RUN echo "export FZF_DEFAULT_COMMAND='rg --files --follow'" >> /etc/bashrc

USER nonroot

ADD vimrc $HOME/.vimrc

CMD vim
