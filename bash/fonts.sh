mkdir -p ~/.fonts
pushd ~/.fonts

wget https://github.com/adobe-fonts/source-code-pro/releases/download/2.038R-ro%2F1.058R-it%2F1.018R-VAR/VAR-source-code-var-1.018R.zip
unzip VAR-source-code-var-1.018R.zip
rm LICENSE.md
rm VAR-source-code-var-1.018R.zip

popd

fc-cache -f -v

