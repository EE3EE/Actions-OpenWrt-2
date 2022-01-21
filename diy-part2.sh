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



# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# Modify default






# 添加额外软件包
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/apps/luci-app-openclash
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/apps/luci-app-amlogic
#git clone https://github.com/xiaorouji/openwrt-passwall package/apps/passwall
git clone https://github.com/rufengsuixing/luci-app-zerotier package/lean/luci-app-zerotier
git clone https://github.com/small-5/luci-app-adblock-plus package/apps/luci-app-adblock-plus
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/apps/luci-app-filebrowser
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-adguardhome package/apps/luci-app-adguardhome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns package/apps/luci-app-smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced package/apps/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-timewol package/apps/luci-app-control-timewol
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-eqos package/apps/luci-app-eqos
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-iptvhelper package/apps/luci-app-iptvhelper
svn co https://github.com/kiddin9/openwrt-packages/trunk/iptvhelper package/apps/iptvhelper
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-mentohust package/apps/luci-app-mentohust
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mentohust package/lean/mentohust
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-rebootschedule package/apps/luci-app-rebootschedule
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat package/apps/luci-app-socat
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-timecontrol package/apps/luci-app-timecontrol
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/lean/luci-app-netdata
git clone https://github.com/ntlf9t/luci-app-easymesh package/lean/luci-app-easymesh







./scripts/feeds update -a
./scripts/feeds install -a
