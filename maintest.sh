#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}


##passwall's depends packages
git clone -b packages --depth 1 https://github.com/xiaorouji/openwrt-passwall
mv -n openwrt-passwall/* ./ ; rm -Rf openwrt-passwall
##passwall's luci-app
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
##helloworld's extra depends packages 
svn export https://github.com/fw876/helloworld/trunk/sagernet-core
svn export https://github.com/fw876/helloworld/trunk/lua-neturl
svn export https://github.com/fw876/helloworld/trunk/redsocks2
##helloworld's luci-app 
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
##jerrykuku's helloworld luci-app
git clone https://github.com/jerrykuku/lua-maxminddb.git  #git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/luci-app-vssr.git  
##luci-app-netdate full Chinese edition
git clone --depth 1 https://github.com/Jason6111/luci-app-netdata luci-app-netdata-cn && sed -i 's/luci-app-netdata/luci-app-netdata-cn/g' luci-app-netdata-cn/Makefile
cp -r luci-app-netdata-cn/po/zh-cn luci-app-iptvhelper-immortalwrt/po/zh_Hans
##immortalwrt's luci-app-adbyby-plus,this app plus wget-ssl better then lede's
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-adbyby-plus luci-app-adbyby-plus-wgets-ssl && sed -i 's/luci-app-adbyby-plus/luci-app-adbyby-plus-wgets-ssl/g' luci-app-adbyby-plus-wgets-ssl/Makefile
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-iptvhelper luci-app-iptvhelper-immortalwrt && sed -i 's/luci-app-iptvhelper/luci-app-iptvhelper-immortalwrt/g' luci-app-iptvhelper-immortalwrt/Makefile && sed -i 's/+iptvhelper/+iptvhelper-immortalwrt/g' luci-app-iptvhelper-immortalwrt/Makefile
cp -r luci-app-iptvhelper-immortalwrt/po/zh_Hans luci-app-iptvhelper-immortalwrt/po/zh-cn
svn export https://github.com/immortalwrt/packages/trunk/net/iptvhelper iptvhelper-immortalwrt  && sed -i 's/PKG_NAME:=iptvhelper/PKG_NAME:=iptvhelper-immortalwrt/g' iptvhelper-immortalwrt/Makefile
##Lienol's luci-app
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol luci-app-control-timewol-byLienol && sed -i 's/luci-app-control-timewol/luci-app-control-timewol-byLienol/g' luci-app-control-timewol-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction luci-app-control-webrestriction-byLienol && sed -i 's/luci-app-control-webrestriction/luci-app-control-webrestriction-byLienol/g' luci-app-control-webrestriction-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl luci-app-control-weburl-byLienol && sed -i 's/luci-app-control-weburl/luci-app-control-weburl-byLienol/g' luci-app-control-weburl-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol luci-app-timecontrol-byLienol && sed -i 's/luci-app-timecontrol/luci-app-timecontrol-byLienol/g' luci-app-timecontrol-byLienol/Makefile
##ddns-go's luci-app and main package
git clone https://github.com/sirpdboy/luci-app-ddns-go.git ddns-go
mv -n ddns-go/* ./ ; rm -Rf ddns-go ; rm README.md
##serverchan's new app
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot
##Chinadns_ng's main packages and luci-app web ui
git clone https://github.com/zfl9/chinadns-ng
git clone -b luci https://github.com/pexcn/openwrt-chinadns-ng.git luci-app-chinadns-ng
##poweroff for device 
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff
cp -r luci-app-poweroff/po/zh-cn luci-app-poweroff/po/zh_Hans
##onliner's luci-app need +luci-app-wrtbwmon
git clone --depth 1 https://github.com/ElvenP/luci-app-onliner
cp -r luci-app-onliner/po/zh-cn luci-app-onliner/po/zh_Hans
#wrtbwmon's main packages and luci-app
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2
##appfilter's main packages and luci-app
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter

svn export https://github.com/kuoruan/openwrt-upx/trunk/upx
svn export https://github.com/kuoruan/openwrt-upx/trunk/ucl
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-wireguard

