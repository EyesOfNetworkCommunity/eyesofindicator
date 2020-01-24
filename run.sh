#!/bin/bash

function install_samples() {
  smashing new /eoi
}

function install_json() {
  echo -e "\ngem 'json'" >> Gemfile
  echo -e "\nAdded json's explicit dependency on Gemfile."
}

function install_widgets() {
  WIDGETS=$@
  if [[ ! -z "$WIDGETS" ]]; then
    for WIDGET in $WIDGETS; do
      echo -e "\nInstalling widget from gist $WIDGET"
      smashing install "$WIDGET"
    done
  fi
}

function install_gems() {
  GEMS=$@
  if [[ ! -z "$GEMS" ]]; then
    echo -e "\nInstalling gem(s): $GEMS"
    for GEM in $GEMS; do
      echo -e "\ngem '$GEM'" >> Gemfile
    done
    bundle install
  fi
}

function install_apks() {
  APKS=$@
  if [[ ! -z "$APKS" ]]; then
    echo -e "\nInstalling apk(s): $APKS"
    for APK in $APKS; do
      apk --no-cache add $APK
    done
  fi
}

if [[ ! -e /installed ]]; then
  install_samples
  install_json
  install_apks $APKS
  install_widgets $WIDGETS
  install_gems $GEMS
  touch /installed
fi

if [[ ! -z "$PORT" ]]; then
  PORT_ARG="-p $PORT"
fi

# Start smashing
exec smashing start $PORT_ARG

