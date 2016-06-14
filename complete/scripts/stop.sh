#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
APP_HOME="`pwd -P`"
cd "$SAVED" >&-

export CLASSPATH=

pushd $APP_HOME/data
gfsh << EOF
    connect --locator=localhost[10334]
    shutdown --include-locators=true
    Y
EOF
popd
