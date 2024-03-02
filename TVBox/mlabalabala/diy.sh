#!/bin/bash
sudo timedatectl set-timezone Asia/Shanghai
echo "sourceURL=https://github.com/mlabalabala/box" >> $GITHUB_ENV 
# echo "tag=$(git log --date=format:'%Y.%m.%d-%H.%M' -1 --pretty=format:%cd)" >> $GITHUB_ENV
# echo "tag=$(date "+%Y年%m月%d日-%H点%M分")" >> $GITHUB_ENV   # 添加编译时间
echo "tag=$(date "+%Y.%m.%d-%H.%M")" >> $GITHUB_ENV   # 添加编译时间
echo "sourceName=M" >> $GITHUB_ENV
echo "diy_TIME=$(date "+%Y.%m.%d")" >> $GITHUB_ENV   # 添加版本号变量
echo '生成日期完成'

touch ./custom.sh
cat << 'EOF' > ./custom.sh
#!/bin/bash
# echo 'crosswalk源，防挂'
# if grep -q 'crosswalk' TVBoxOSC/build.gradle; then
# sed -i "/crosswalk/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
# else
# sed -i "/jitpack.io/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
# fi

echo '更改软件包名使共存'
sed -i 's/tv.org.eu.bunnyabc/com.github.tvbox.osc.qtm/g' TVBoxOSC/app/build.gradle

echo '关于更改'
sed -i '/android:text=/d' TVBoxOSC/app/src/main/res/layout/dialog_about.xml
sed -i '/ingMultiplier=/a\        android:text="        本软件只提供聚合展示功能，所有资源来自网上, 软件不参与任何制作, 上传, 储存, 下载等内容. 软件仅供学习参考, 请于安装后24小时内删除。\\n\\n\\n                                                                    QTM 编译"' TVBoxOSC/app/src/main/res/layout/dialog_about.xml

echo '修改请勿商用以及播放违法内容'
sed -i 's/开源测试软件,请勿商用以及播放违法内容/请勿商用以及播放违法内容/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/LivePlayActivity.java

echo '添加内置播放源地址'
sed -i 's|API_URL, ""|API_URL, "https://cyao.eu.org/files/n.json"|g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/api/ApiConfig.java
echo '添加内置直源地址'
sed -i 's|LIVE_URL, ""|LIVE_URL, "https://cyao.eu.org/files/n.json"|g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/api/ApiConfig.java
echo '添加内置EPG地址'
sed -i 's|EPG_URL, ""|EPG_URL, "https://cyao.eu.org/files/n.json"|g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/api/ApiConfig.java

echo '修改界面首页为主页'
sed -i 's/请选择首页数据源/请选择主页数据源/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/HomeActivity.java
sed -i 's/自定义jar加载成功/数据加载成功/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/HomeActivity.java
sed -i 's/jar加载失败/数据加载失败/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/HomeActivity.java

echo '修改数据源列表，超过10个源起用三列排列'
sed -i 's/Math.floor(sites.size()\/60/Math.floor(sites.size()\/10/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/HomeActivity.java

echo '修改远程管理首页名'
sed -i 's/T V B O X/QTM影视/g' TVBoxOSC/app/src/main/res/raw/index.html
sed -i 's/搜 索/QTM影视 . 搜索/g' TVBoxOSC/app/src/main/res/raw/index.html
sed -i 's/推 送/QTM影视 . 推送/g' TVBoxOSC/app/src/main/res/raw/index.html
sed -i 's/接 口/QTM影视 . 接口/g' TVBoxOSC/app/src/main/res/raw/index.html

echo '软件名称修改'
sed -i 's/Jade/QTM影视/g' TVBoxOSC/app/src/main/res/values/strings.xml

echo '图标修改'
cp -f TVBox/img/01/app_icon.png TVBoxOSC/app/src/main/res/drawable-hdpi/app_icon.png
cp -f TVBox/img/02/app_icon.png TVBoxOSC/app/src/main/res/drawable-xhdpi/app_icon.png
cp -f TVBox/img/03/app_icon.png TVBoxOSC/app/src/main/res/drawable-xxhdpi/app_icon.png
cp -f TVBox/img/04/app_icon.png TVBoxOSC/app/src/main/res/drawable-xxxhdpi/app_icon.png

echo '背景修改'
cp -f TVBox/img/bg/app_bg.png TVBoxOSC/app/src/main/res/drawable/app_bg.png
cp -f TVBox/img/app_banner.png TVBoxOSC/app/src/main/res/drawable/app_banner.png
cp -f TVBox/img/04/app_icon.png TVBoxOSC/app/src/main/res/drawable/app_icon.png

#播放界面修改 1.底部控件重排 2.直播增加分辨率显示
# cp TVBox/q215613905/xmljava/activity_live_play.xml TVBoxOSC/app/src/main/res/layout/activity_live_play.xml
# cp TVBox/q215613905/xmljava/player_vod_control_view.xml TVBoxOSC/app/src/main/res/layout/player_vod_control_view.xml
# cp TVBox/q215613905/xmljava/VodController.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java
# cp TVBox/q215613905/xmljava/LivePlayActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

#修改播放器进度条消失时间
sed -i 's/10000/6000/g'  TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/player/controller/VodController.java

#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/ui/activity/HomeActivity.java

#进度条颜色
sed -i 's/color_6C3D3D3D/color_1890FF/g' TVBoxOSC/app/src/main/res/drawable/shape_player_control_vod_seek.xml

#长按倍速修改为2
# sed -i 's/3.0/2.0/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/bbox/player/controller/VodController.java

#FongMi的jar支持
# echo "" >> TVBoxOSC/app/proguard-rules.pro
# echo "-keep class com.google.gson.**{*;}" >> TVBoxOSC/app/proguard-rules.pro
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

#添加添加PY支持
touch ./add-py.sh
cat << 'EOF' > ./add-py.sh
#!/bin/bash
echo '添加PY支持'
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O TVBoxOSC/app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" TVBoxOSC/app/build.gradle
sed -i 's#@#\\#g' TVBoxOSC/app/build.gradle
sed -i 's#pyramid#\\pyramid#g' TVBoxOSC/app/build.gradle
echo "" >> TVBoxOSC/app/proguard-rules.pro
echo "#添加PY支持" >> TVBoxOSC/app/proguard-rules.pro
echo "-keep public class com.undcover.freedom.pyramid.** { *; }" >> TVBoxOSC/app/proguard-rules.pro
echo "-dontwarn com.undcover.freedom.pyramid.**" >> TVBoxOSC/app/proguard-rules.pro
echo "-keep public class com.chaquo.python.** { *; }" >> TVBoxOSC/app/proguard-rules.pro
echo "-dontwarn com.chaquo.python.**" >> TVBoxOSC/app/proguard-rules.pro
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.undcover.freedom.pyramid.PythonLoader;' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.github.catvod.crawler.SpiderNull;' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/PlayerHelper.init/a\        PythonLoader.getInstance().setApplication(this);' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import android.util.Base64;/a\import com.github.catvod.crawler.SpiderNull;' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/import android.util.Base64;/a\import com.undcover.freedom.pyramid.PythonLoader;' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/private void parseJson(String apiUrl, String jsonStr)/a\        PythonLoader.getInstance().setConfig(jsonStr);' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Spider getCSP(SourceBean sourceBean)/a\        if (sourceBean.getApi().startsWith(\"py_\")) {\n        try {\n            return PythonLoader.getInstance().getSpider(sourceBean.getKey(), sourceBean.getExt());\n        } catch (Exception e) {\n            e.printStackTrace();\n            return new SpiderNull();\n        }\n    }' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Object\[\] proxyLoca/a\    try {\n        if(param.containsKey(\"api\")){\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"ck\"))\n                return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n            SourceBean sourceBean = ApiConfig.get().getSource(doStr);\n            return PythonLoader.getInstance().proxyLocal(sourceBean.getKey(),sourceBean.getExt(),param);\n        }else{\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"live\")) return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n        }\n    } catch (Exception e) {\n        e.printStackTrace();\n    }\n' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
echo '添加PY支持完成'
EOF
chmod +x ./add-py.sh

#添加arm64-v8a
touch ./arm64-v8a.sh
cat << 'EOF' > ./arm64-v8a.sh
#!/bin/bash
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'arm64-v8a'#" TVBoxOSC/app/build.gradle
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'arm64-v8a'#" TVBoxOSC/player/build.gradle
echo '添加arm64-v8a完成'
EOF
chmod +x ./arm64-v8a.sh

#添加add-X86
touch ./add-X86.sh
cat << 'EOF' > ./add-X86.sh
#!/bin/bash
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'x86', 'x86_64'#" TVBoxOSC/app/build.gradle
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'x86', 'x86_64'#" TVBoxOSC/player/build.gradle
echo '添加add-X86完成'
EOF
chmod +x ./add-X86.sh

# echo "javaVersion=17" >> $GITHUB_ENV
