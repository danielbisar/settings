#!/bin/bash

function install-fd()
{
    pushd ~/.db

    wget "https://github.com/sharkdp/fd/releases/download/v8.3.2/fd-v8.3.2-x86_64-unknown-linux-gnu.tar.gz"
    tar -xf "fd-v8.3.2-x86_64-unknown-linux-gnu.tar.gz"
    cd "fd-v8.3.2-x86_64-unknown-linux-gnu"
    mv fd ..
    mv fd.1 ..
    mv complete/fd.bash ../bash_compl.d/
    
    popd
}


