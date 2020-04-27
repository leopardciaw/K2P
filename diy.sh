#/bin/bash
#=================================================
# Description: OpenWrt DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
# sed '1,3s/my/your/g'
# sed -i '93s/0xf60000/0x1fb0000/g' target/
#=================================================
# Modify default IP
# sed -i 's/15744/32448/g' https://github.com/coolsnowwolf/lede/blob/3d3a95e5b440892df849a85b2dfb8482414ee43a/target/linux/ramips/image/mt7621.mk#L686
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 修改K2P闪存和内存
# sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk
# sed -i 's/0xf60000/0x1fb0000/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
rm -rf target/linux/ramips/image/mt7621.mk
rm -rf target/linux/ramips/dts/mt7621_phicomm_k2p.dts
cp -rf ../mt7621.mk target/linux/ramips/image/
cp -rf ../mt7621_phicomm_k2p.dts target/linux/ramips/dts/

# 删除原主题包
# rm -rf package/lean/luci-theme-argon
# rm -rf openwrt/package/lean/luci-theme-netgear

# 添加新的主题包
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# git clone https://github.com/sypopo/luci-theme-atmaterial.git package/lean/luci-theme-atmaterial
git clone https://github.com/sypopo/luci-theme-argon-mc.git package/lean/luci-theme-argon-mc

# 取消bootstrap为默认主题
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

#增加koolddns
# git clone https://github.com/xrouterservice/luci-app-koolddns.git package/lean/luci-app-koolddns

# 更新
# ./scripts/feeds update -a && ./scripts/feeds install -a

##########
# Modify the version number
sed -i 's/OpenWrt/Leopard build $(date "+%Y.%m.%d") @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="Leopard"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"Leopard"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config

# 增加ssr
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
