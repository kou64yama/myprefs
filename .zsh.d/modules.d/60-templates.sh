#!/bin/zsh -f

headergen() {
    local uuid=UUID_`uuidgen | tr "[:lower:]" "[:upper:]" | tr "-" "_"`
    echo "#ifndef $uuid"
    echo "#define $uuid"
    echo
    echo "#endif /* $uuid */"
}
