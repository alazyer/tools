#!/bin/bash

install_vim(){
    sudo apt-get install -yq vim
    sudo apt-get install -yq ctags
    sudo apt-get install -yq build-essential cmake python-dev
    sudo apt-get install -yq silversearcher-ag

    git clone https://github.com/wklken/k-vim.git ~/.vim

    ln -sf ~/.vim/vimrc ~/.vimrc
    ln -sf ~/.vim/vimrc.bundles ~/.vimrc.bundles

    vim -u ~/.vimrc.bundles +PlugInstall! +PlugClean! +qall

    cd ~/.vim/bundle/YouCompleteMe/
    git submodule update --init --recursive
    if [ `which clang` ]   # check system clang
    then
        python install.py --clang-completer --system-libclang   # use system clang
    else
        python install.py --clang-completer
    fi
}



install_zsh() {
    sudo apt-get install -yq zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sed 's/^ZSH_THEME.*/ZSH_THEME="candy"/g' ~/.zshrc
    chsh -s /bin/zsh
}

install_vim
install_zsh
