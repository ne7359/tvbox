#!/bin/bash
git clone -b main --depth=1 https://github.com/takagen99/Box TVBoxOSC
chmod +x ./TVBoxOSC
diy_TIME=$(date "+%Y.%m.%d")
cat << 'EOF' > ./config.sh
#!/bin/bash
echo 'crosswalk源，防挂'
if grep -q 'crosswalk' TVBoxOSC/build.gradle; then
sed -i "/crosswalk/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
else
sed -i "/jitpack.io/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
fi

#echo '更改软件包名使共存'
#sed -i 's/com.github.tvbox.osc.tk/com.github.tvbox.osc.qtm/g' TVBoxOSC/app/build.gradle

echo '版本降低至19 安卓4.4
sed -i '/minSdkVersion/d' TVBoxOSC/app/build.gradle
sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 17' TVBoxOSC/app/build.gradle
sed -i '/targetSdkVersion/d' TVBoxOSC/app/build.gradle
sed -i '/minSdkVersion/a\        targetSdkVersion 26' TVBoxOSC/app/build.gradle

echo '修改-关于'
sed -i '/android:text=/d' TVBoxOSC/app/src/main/res/layout/dialog_about.xml
sed -i '/shadowRadius=/a\        android:text="        本软件只提供聚合展示功能，所有资源来自网上, 软件不参与任何制作, 上传, 储存, 下载等内容. 软件仅供学习参考, 请于安装后24小时内删除。\\n\\n\\n                                                                    QTM 编译"' TVBoxOSC/app/src/main/res/layout/dialog_about.xml

echo '关于插入版本号'
sed -i "/versionName/s#[0-9a-zA-Z_\.\'\"-]\+\$#\'版本号：${diy_TIME}\'#" TVBoxOSC/app/build.gradle
sed -i "/android:text=/s#=\"#=\"版本号：${diy_TIME}\\\\n\\\\n#" TVBoxOSC/app/src/main/res/layout/dialog_about.xml 

echo '修改远程管理首页名'
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/raw/index.html

echo '软件名称修改'
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/values/strings.xml
echo '添加内置播放源地址'
sed -i 's#"app_source"><#"app_source">https://cyao.eu.org/files/n.json<#g' TVBoxOSC/app/src/main/res/values-zh/strings.xml

#图标修改
mv TVBox/img/d/app_icon.png TVBoxOSC/app/src/main/res/drawable/app_icon.png
mv TVBox/img/app_banner.png TVBoxOSC/app/src/main/res/drawable/app_banner.png

#背景修改
# mv TVBox/img/bg/app_bg.png TVBoxOSC/app/src/main/res/drawable/app_bg.png

# 主页UI调整 恢复老版；默认多行显示
cp TVBox/Txmljava/fragment_user.xml TVBoxOSC/app/src/main/res/layout/fragment_user.xml

# 整体布局修改
cp TVBox/Txmljava/BaseActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 主页增加每日一言/去除部分图标
#cp TVBox/Txmljava/ApiConfig.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
#cp TVBox/Txmljava/activity_home.xml TVBoxOSC/app/src/main/res/layout/activity_home.xml
#cp TVBox/Txmljava/HomeActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

# 默认设置修改
#cp TVBox/Txmljava/App.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/App.java 

# 取消首页从通知栏位置布置
#cp TVBox/Txmljava/BaseActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 直播添加epg112114支持
#cp TVBox/Txmljava/LivePlayActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

# 搜索改为爱奇艺热词，支持首字母联想
#cp TVBox/Txmljava/SearchActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java

#长按倍速修改为2
#sed -i 's/3.0/2.0/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#FongMi的jar支持
echo "" >> TVBoxOSC/app/proguard-rules.pro
echo "-keep class com.google.gson.**{*;}" >> TVBoxOSC/app/proguard-rules.pro

echo '签名'
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " TVBoxOSC/app/build.gradle
cp -f TVBox/TVBoxOSC.jks TVBoxOSC/app/TVBoxOSC.jks
sed -i '$a\RELEASE_STORE_FILE=./TVBoxOSC.jks'     TVBoxOSC/gradle.properties
sed -i '$a\RELEASE_KEY_ALIAS=TVBoxOSC'            TVBoxOSC/gradle.properties
sed -i '$a\RELEASE_STORE_PASSWORD=TVBoxOSC'       TVBoxOSC/gradle.properties
sed -i '$a\RELEASE_KEY_PASSWORD=TVBoxOSC'         TVBoxOSC/gradle.properties
echo 'DIY 完成'
EOF
chmod +x ./config.sh
# echo "javaVersion=17" >> $GITHUB_ENV
