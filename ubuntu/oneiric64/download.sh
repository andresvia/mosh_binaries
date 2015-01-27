#!/bin/bash -eux

mirror=http://old-releases.ubuntu.com/ubuntu
temp_dir=$(mktemp -d /tmp/tmp.XXXXXX)

trap "rm -rfv $temp_dir" EXIT

pushd $temp_dir

pkgs=(
$mirror/pool/universe/m/mosh/mosh_1.1-1~oneiric1_amd64.deb
$mirror/pool/main/p/protobuf/libprotobuf5_2.2.0a-0.1ubuntu1_amd64.deb
$mirror/pool/universe/libu/libutempter/libutempter0_1.1.5-2_amd64.deb
)

bins=(
usr/bin/mosh-server
usr/lib/libprotobuf.so.5
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

