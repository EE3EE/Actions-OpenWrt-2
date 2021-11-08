#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 删除软件包
rm -rf package/lean/luci-app-zerotier
rm -rf package/lean/mentohust
rm -rf feeds/packages/net/smartdns
rm -rf feeds/packages/net/socat
rm -rf feeds/packages/net/kcptun
rm -rf package/lean/luci-app-netdata
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/admin/netdata
rm -rf package/lean/trojan
rm -rf package/lean/simple-obfs
rm -rf package/lean/pdnsd-alt
rm -rf package/lean/ipt2socks
rm -rf package/lean/dns2socks
rm -rf feeds/luci/applications/luci-app-dawn
rm -rf package/lean/luci-app-easymesh
 
# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# Modify default
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' feeds/luci/collections/luci/Makefile
sed -i 's#root::0:0:99999:7:::#root:$1$wEehtjxj$YBu4quNfVUjzfv8p/PBo5.:0:0:99999:7:::#g' package/base-files/files/etc/shadow
#sed -i 's/R21.10.1/R21.10.12/g' package/lean/default-settings/files/zzz-default-settings
sed -i '34d' package/lean/default-settings/files/zzz-default-settings

# 添加额外软件包
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone https://github.com/rufengsuixing/luci-app-zerotier package/lean/luci-app-zerotier
git clone https://github.com/small-5/luci-app-adblock-plus package/luci-app-adblock-plus
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-adguardhome package/luci-app-adguardhome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/AdGuardHome package/AdGuardHome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced package/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-timewol package/luci-app-control-timewol
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-eqos package/luci-app-eqos
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-iptvhelper package/luci-app-iptvhelper
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/iptvhelper package/iptvhelper
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-mentohust package/luci-app-mentohust
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mentohust package/lean/mentohust
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-rebootschedule package/luci-app-rebootschedule
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat package/luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/socat feeds/packages/net/socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-timecontrol package/luci-app-timecontrol
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/lean/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata feeds/packages/admin/netdata
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-dawn feeds/luci/applications/luci-app-dawn
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-dockerman package/luci-app-dockerman
git clone https://github.com/ntlf9t/luci-app-easymesh package/lean/luci-app-easymesh

# luci-app-easymesh
sed -i 's/wpad-mesh-openssl/wpad-openssl/g' package/lean/luci-app-easymesh/Makefile

# 删除docker无脑初始化教程
sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
rm -rf package/lean/luci-app-docker/root/www

# 晶晨宝盒
sed -i "s|https.*/amlogic-s9xxx-openwrt|https://github.com/breakings/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt/opt/kernel|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|s9xxx_lede|ARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|.img.gz|..OPENWRT_SUFFIX|g" package/luci-app-amlogic/root/etc/config/amlogic

# readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

./scripts/feeds update -a
./scripts/feeds install -a