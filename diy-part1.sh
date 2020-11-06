#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# fw876/helloworld
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i 's@coolsnowwolf/packages@P3TERX/packages@' feeds.conf.default

#获取Lienol-xiaorouji-passwall
# git clone https://github.com/xiaorouji/openwrt-package/lienol/ package/diy-packages/lienol
git clone https://github.com/kenzok8/openwrt-packages.git package/diy-packages
# git clone https://github.com/xiaorouji/openwrt-package/tree/master/lienol/luci-app-passwall package/luci-app-passwall
git clone https://github.com/kenzok8/small.git package/small

# 删除和替换文件，便于K2P支持32M闪存（没有硬改为32M的不用此步骤）
# sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk
# sed -i 's/0xf60000/0x1fb0000/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
rm -rf target/linux/ramips/image/mt7621.mk
rm -rf target/linux/ramips/dts/mt7621_phicomm_k2p.dts
cp -rf ../mt7621.mk target/linux/ramips/image/
cp -rf ../mt7621_phicomm_k2p.dts target/linux/ramips/dts/

# 增加ssr
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
# git clone https://github.com/fw876/helloworld.git package/openwrt-packages/luci-app-ssr-plus
