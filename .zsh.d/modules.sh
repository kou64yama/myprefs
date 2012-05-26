#!/bin/zsh

for file in $(find "${HOME}/.zsh.d/modules.d" -follow -type f -name "*.sh"); do
    source ${file}
done

unset file
