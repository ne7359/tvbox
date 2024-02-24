#!/bin/bash
sudo timedatectl set-timezone Asia/Shanghai
echo "sourceURL=https://github.com/mlcs-top/iTVBox" >> $GITHUB_ENV 
# echo "tag=$(git log --date=format:'%Y.%m.%d-%H.%M' -1 --pretty=format:%cd)" >> $GITHUB_ENV
# echo "tag=$(date "+%Y年%m月%d日-%H点%M分")" >> $GITHUB_ENV   # 添加编译时间
echo "tag=$(date "+%Y.%m.%d-%H.%M")" >> $GITHUB_ENV   # 添加编译时间
echo "sourceName=ml" >> $GITHUB_ENV
echo "diy_TIME=$(date "+%Y.%m.%d")" >> $GITHUB_ENV   # 添加版本号变量
echo '生成日期完成'

touch ./custom.sh
cat << 'EOF' > ./custom.sh
#!/bin/bash
# 未测试
echo '版本降低至18 安卓4.4'
sed -i '/minSdkVersion/d' TVBoxOSC/app/build.gradle
sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 18' TVBoxOSC/app/build.gradle
sed -i '/targetSdkVersion/d' TVBoxOSC/app/build.gradle
sed -i '/minSdkVersion/a\        targetSdkVersion 29' TVBoxOSC/app/build.gradle

#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#进度条颜色
sed -i 's/color_353744/color_1890FF/g' TVBoxOSC/app/src/main/res/drawable/shape_player_control_vod_seek.xml
EOF
chmod +x ./custom.sh

touch ./ApkSign.sh
cat << 'EOF' > ./ApkSign.sh
#!/bin/bash
echo '给APP签名'
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
echo '给APP签名 完成'
EOF
chmod +x ./ApkSign.sh
