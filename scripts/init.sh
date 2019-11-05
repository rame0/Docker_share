#!/bin/bash

echo "$APT_INSTALL"
echo "$PECL_INSTALL"
echo "$EXTS_ENABLE"

apt-get update

if [ "$APT_INSTALL" != "-" ]
then
  echo "install dependencies"
  IFS=' ' read -r -a libarr <<< "$APT_INSTALL"
  for libel in "${libarr[@]}"
  do
      apt-get install $libel -y
  done
fi

if [ "$PECL_INSTALL" != "-" ]
then
  echo "install pecl"
  IFS=' ' read -r -a peaarr <<< "$PECL_INSTALL"
  for peael in "${peaarr[@]}"
  do
      pecl install "$peael"
  done
fi

if [ "$EXTS_INSTALL" != "-" ]
then
  echo "install ext"
  docker-php-ext-install -j"$(nproc)" $EXTS_INSTALL
fi

if [ "$EXTS_ENABLE" != "-" ]
then
  echo "enable ext"
  docker-php-ext-enable $EXTS_ENABLE
fi