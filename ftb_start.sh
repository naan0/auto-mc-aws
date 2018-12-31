#!/bin/bash
if [ ! -e /ftb/.init_done ] ; then
  ./ftb_init.sh $@
fi
cd /ftb && ./ServerStart.sh
