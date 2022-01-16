install-vim-coc()
{
    # coc for vim/nvim
    # Install extensions
    mkdir -p ~/.config/coc/extensions
    pushd ~/.config/coc/extensions

    if [ ! -f package.json ]
    then
        echo '{"dependencies":{}}'> package.json
    fi

    # Change extension names to the extensions you need
    npm install coc-marketplace coc-clangd coc-cmake coc-omnisharp coc-snippets coc-sql coc-vimlsp --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

    popd
}
