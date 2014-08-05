#!/bin/bash -eux

mirror=http://mirrors.kernel.org/ubuntu

temp_dir=$(mktemp -d)

trap "rm -rfv $temp_dir" EXIT

pushd $temp_dir

pkgs=(
$mirror/pool/universe/m/mosh/mosh_1.2.4a-1~ubuntu12.04.1_amd64.deb
$mirror/pool/main/p/protobuf/libprotobuf7_2.4.1-1ubuntu2_amd64.deb
$mirror/pool/main/libu/libutempter/libutempter0_1.1.5-4_amd64.deb
)

bins=(
usr/bin/mosh-server
usr/lib/libprotobuf.so.7
usr/lib/libutempter.so.0
)

for deb_pkg in ${pkgs[@]}
do
  wget $deb_pkg
  ar xv $(basename "$deb_pkg")
  tar xvzf data.tar.gz
done

popd

for bin in ${bins[@]}
do
  rm -vf $bin
  cp -Lvf $temp_dir/$bin .
done

