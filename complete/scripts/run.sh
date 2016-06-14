#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
APP_HOME="`pwd -P`"
cd "$SAVED" >&-

export CLASSPATH=

mkdir -p $APP_HOME/data/locator

pushd $APP_HOME/data/locator

gfsh start locator --name=locator_`hostname` --bind-address=127.0.0.1 --initial-heap=128m --max-heap=128m --dir=$APP_HOME/data/locator --port=10334

popd

mkdir -p $APP_HOME/data/server1
mkdir -p $APP_HOME/data/server2

pushd $APP_HOME/data
gfsh << EOF
    connect --locator=localhost[10334]
    start server --name=server1 --server-port=0 --bind-address=127.0.0.1 --dir=server1
    start server --name=server2 --server-port=0 --bind-address=127.0.0.1 --dir=server2

    create region --name=hello --type=REPLICATE
EOF
popd
