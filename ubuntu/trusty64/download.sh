#!/bin/bash -eux

mirror=http://mirrors.kernel.org/ubuntu

temp_dir=$(mktemp -d /tmp/tmp.XXXXXX)

trap "rm -rfv $temp_dir" EXIT

pushd $temp_dir

pkgs=(
$mirror/pool/universe/m/mosh/mosh_1.2.4a-1ubuntu1_amd64.deb
$mirror/pool/main/p/protobuf/libprotobuf8_2.5.0-9ubuntu1_amd64.deb
$mirror/pool/main/libu/libutempter/libutempter0_1.1.5-4build1_amd64.deb
)

bins=(
usr/bin/mosh-server
usr/lib/x86_64-linux-gnu/libprotobuf.so.8
usr/lib/libutempter.so.0
)

for deb_pkg in ${pkgs[@]}
do
  wget $deb_pkg
  ar xv $(basename "$deb_pkg")
  tar xvf data.tar.*
  rm -rvf data.tar.*
done

popd

for bin in ${bins[@]}
do
  rm -vf $bin
  cp -Lvf $temp_dir/$bin .
done

