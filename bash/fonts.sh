mkdir -p ~/.fonts
pushd ~/.fonts

wget https://github.com/adobe-fonts/source-code-pro/releases/download/1.017R/source-code-pro-1.017R.zip
unzip source-code-pro-1.017R.zip
rm LICENSE.md
rm source-code-pro-1.017R.zip


popd
fc-cache -f -v

