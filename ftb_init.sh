#!/bin/sh
set -ex

#download modpack, run installs, etc..
if [ "$FTB_MODPACK_URL" ] ; then
  cd /ftb
  echo "Downloading pack from $FTB_MODPACK_URL"
  wget -qO modpack.zip `echo $FTB_MODPACK_URL | tr -d '"'`
  unzip -q modpack.zip

  if [ -e FTBInstall.sh ] ; then
    chmod u+x FTBInstall.sh   
    ./FTBInstall.sh
  elif [ -e Install.sh ] ; then
    chmod u+x Install.sh
    ./Install.sh
  fi

  if [ "$MAX_RAM" ] ; then
    echo "export MAX_RAM=\"$MAX_RAM\"" >> settings_local.sh
    if [ -e settings.sh ] ; then
      mv settings.sh settings.sh.old
      cat settings.sh.old | grep -v MAX_RAM > settings.sh
      rm settings.sh.old
    fi
  fi

  if [ "$EULA_ACCEPTED" == "true" ] ; then
    printf "#`date`\neula=$EULA_ACCEPTED" > eula.txt
  else
    echo "ERROR: Accept the minecraft EULA by providing the variable EULA_ACCEPTED set to TRUE. By changing this to TRUE you are indicating your agreement to the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula)."
    exit 1
  fi 
  if [ ! -e ./ServerStart.sh ] && [ -e ./serverstart.bat ] ; then
    head -n 1 ./serverstart.bat > ./ServerStart.sh
    sed -i 's/java/java -Dfml.queryResult=confirm/g' ./ServerStart.sh #just in case this dialog pops in
  fi
  chmod u+x ServerStart.sh
  ln -s /world world
  MANAGED_FILES='server.properties banned-ips.json banned-players.json ops.json server-icon.png whitelist.json'
  mkdir -p /world/auto-mc-aws/
  for file in $MANAGED_FILES ; do
    rm $file ||:
    ln -s /world/auto-mc-aws/$file $file
  done
  touch .init_done
else
  echo "ERROR: FTB_MODPACK_URL variable was not defined!"
  exit 1
fi
