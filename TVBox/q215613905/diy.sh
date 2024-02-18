#!/bin/bash
git clone https://github.com/q215613905/TVBoxOS TVBoxOSC

echo 'crosswalk源，防挂'
if grep -q 'crosswalk' build.gradle; then
sed -i "/crosswalk/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" build.gradle
else
sed -i "/jitpack.io/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" build.gradle
fi

echo '更改软件包名使共存'
sed -i 's/com.github.tvbox.osc/com.github.tvbox.osc.qtm/g' diyTVBOX/TVBoxOSC/app/build.gradle
echo '关于更改'
sed -i '/android:text=/d' diyTVBOX/TVBoxOSC/app/src/main/res/layout/dialog_about.xml
sed -i '/ingMultiplier=/a\        android:text="        本软件只提供聚合展示功能，所有资源来自网上, 软件不参与任何制作, 上传, 储存, 下载等内容. 软件仅供学习参考, 请于安装后24小时内删除。\\n\\n\\n                                                                    QTM 编译"' diyTVBOX/TVBoxOSC/app/src/main/res/layout/dialog_about.xml
echo '关于插入版本号'
sed -i "/versionName/s#[0-9a-zA-Z_\.\'\"-]\+\$#\'版本号：2023.12\'#" diyTVBOX/TVBoxOSC/app/build.gradle
sed -i "/android:text=/s#=\"#=\"版本号：2023.12\\\\n\\\\n#" diyTVBOX/TVBoxOSC/app/src/main/res/layout/dialog_about.xml 
echo '修改请勿商用以及播放违法内容'
sed -i 's/开源测试软件,请勿商用以及播放违法内容/请勿商用以及播放违法内容/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java
echo '添加内置播放源地址'
sed -i 's|API_URL, ""|API_URL, "https://f.cyao.tk/n.json"|g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
echo '修改界面首页为主页'
sed -i 's/请选择首页数据源/请选择主页数据源/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/自定义jar加载成功/数据加载成功/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
sed -i 's/jar加载失败/数据加载失败/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
echo '修改数据源列表，超过10个源起用三列排列'
sed -i 's/Math.floor(sites.size()\/60/Math.floor(sites.size()\/10/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
echo '修改远程管理首页名'
sed -i 's/TVBox/QTM影视/g' diyTVBOX/TVBoxOSC/app/src/main/res/raw/index.html
echo '软件名称修改'
sed -i 's/TVBox/QTM影视/g' diyTVBOX/TVBoxOSC/app/src/main/res/values/strings.xml
echo '图标修改'
mv $CURRENT_DIR/TVBox/DIY/PNG/a/app_icon.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable-hdpi/app_icon.png
mv $CURRENT_DIR/TVBox/DIY/PNG/b/app_icon.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable-xhdpi/app_icon.png
mv $CURRENT_DIR/TVBox/DIY/PNG/c/app_icon.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable-xxhdpi/app_icon.png
mv $CURRENT_DIR/TVBox/DIY/PNG/d/app_icon.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable-xxxhdpi/app_icon.png
echo '背景修改'
#mv -f diyTVBOX/TVBoxOSC/app/src/main/res/drawable/app_bg.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable/app_bg2.png
mv $CURRENT_DIR/TVBox/DIY/PNG/bg/app_bg.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable/app_bg.png
#cp -f $CURRENT_DIR/TVBox/DIY/PNG/bg_a/app_bg.png diyTVBOX/TVBoxOSC/app/src/main/res/drawable/app_bg1.png

#播放界面修改 1.底部控件重排 2.直播增加分辨率显示
cp $CURRENT_DIR/TVBox/q215613905/J/activity_live_play.xml diyTVBOX/TVBoxOSC/app/src/main/res/layout/activity_live_play.xml
cp $CURRENT_DIR/TVBox/q215613905/J/player_vod_control_view.xml diyTVBOX/TVBoxOSC/app/src/main/res/layout/player_vod_control_view.xml
cp $CURRENT_DIR/TVBox/q215613905/J/VodController.java diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java
cp $CURRENT_DIR/TVBox/q215613905/J/LivePlayActivity.java diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

#修改播放器进度条消失时间
sed -i 's/10000/6000/g'  diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' diyTVBOX/TVBoxOSC/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#进度条颜色
sed -i 's/color_353744/color_1890FF/g' diyTVBOX/TVBoxOSC/app/src/main/res/drawable/shape_player_control_vod_seek.xml

#长按倍速修改为2
sed -i 's/3.0/2.0/g' diyTVBOX/TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#FongMi的jar支持
echo "" >> diyTVBOX/TVBoxOSC/app/proguard-rules.pro
echo "-keep class com.google.gson.**{*;}" >> diyTVBOX/TVBoxOSC/app/proguard-rules.pro

echo '签名'
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " diyTVBOX/TVBoxOSC/app/build.gradle
cp -f $CURRENT_DIR/TVBox/DIY/TVBoxOSC.jks diyTVBOX/TVBoxOSC/app/TVBoxOSC.jks
cp -f $CURRENT_DIR/TVBox/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/TVBoxOSC.jks
echo "" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_FILE=./TVBoxOSC.jks" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_ALIAS=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo 'DIY 完成'
