#!/bin/bash
set -ex
if [ ! -e /ftb/.init_done ] ; then
  ./ftb_init.sh $@
fi
cd /ftb && ./ServerStart.sh
