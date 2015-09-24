#!/usr/bin/env sh

message() {
  echo -e "\033[34m$@\033[m"
}

ask() {
  echo -e "\033[35m$@\033[m"
}

warn() {
  echo -e "\033[33m$@\033[m"
}

succeed() {
  echo -e "\033[36m$@\033[m"
}

fail() {
  echo -e "\033[31m$@\033[m"
}
