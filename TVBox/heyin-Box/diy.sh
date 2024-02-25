###
# takagen99 修改版
###
#!/bin/bash
sudo timedatectl set-timezone Asia/Shanghai
echo "sourceURL=https://github.com/HongFeiQ/heyin-Box" >> $GITHUB_ENV 
# echo "tag=$(git log --date=format:'%Y.%m.%d-%H.%M' -1 --pretty=format:%cd)" >> $GITHUB_ENV
# echo "tag=$(date "+%Y年%m月%d日-%H点%M分")" >> $GITHUB_ENV   # 添加编译时间
echo "tag=$(date "+%Y.%m.%d-%H.%M")" >> $GITHUB_ENV   # 添加编译时间
echo "sourceName=T" >> $GITHUB_ENV
echo "diy_TIME=$(date "+%Y.%m.%d")" >> $GITHUB_ENV   # 添加版本号变量
echo '生成日期完成'

touch ./custom.sh
cat << 'EOF' > ./custom.sh
#!/bin/bash
echo 'crosswalk源，防挂'
if grep -q 'crosswalk' TVBoxOSC/build.gradle; then
sed -i "/crosswalk/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
else
sed -i "/jitpack.io/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" TVBoxOSC/build.gradle
fi

#echo '更改软件包名使共存'
#sed -i 's/com.github.tvbox.osc.tk/com.github.tvbox.osc.qtm/g' TVBoxOSC/app/build.gradle

# 好用
#echo '版本降低至16 安卓4.4'
#sed -i 's/compileSdk 33/compileSdk 30/g' TVBoxOSC/app/build.gradle
#sed -i '/minSdkVersion/d' TVBoxOSC/app/build.gradle
#sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 16' TVBoxOSC/app/build.gradle

# 未测试
echo '版本降低至18 安卓4.4'
sed -i '/minSdkVersion/d' TVBoxOSC/app/build.gradle
#sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 18' TVBoxOSC/app/build.gradle
sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 21' TVBoxOSC/app/build.gradle
sed -i '/targetSdkVersion/d' TVBoxOSC/app/build.gradle
#sed -i '/minSdkVersion/a\        targetSdkVersion 26' TVBoxOSC/app/build.gradle
sed -i '/minSdkVersion/a\        targetSdkVersion 29' TVBoxOSC/app/build.gradle

echo '修改-关于'
sed -i '/android:text=/d' TVBoxOSC/app/src/main/res/layout/dialog_about.xml
sed -i '/shadowRadius=/a\        android:text="        本软件只提供聚合展示功能，所有资源来自网上, 软件不参与任何制作, 上传, 储存, 下载等内容. 软件仅供学习参考, 请于安装后24小时内删除。\\n\\n\\n                                                                    QTM 编译"' TVBoxOSC/app/src/main/res/layout/dialog_about.xml

echo '修改远程管理首页名'
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/raw/index.html

echo '软件名称修改'
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/QTM影视/g' TVBoxOSC/app/src/main/res/values/strings.xml
echo '添加内置播放源地址'
sed -i 's#"app_source"><#"app_source">https://cyao.eu.org/files/n.json<#g' TVBoxOSC/app/src/main/res/values-zh/strings.xml

#图标修改
mv TVBox/img/04/app_icon.png TVBoxOSC/app/src/main/res/drawable/app_icon.png
mv TVBox/img/app_banner.png TVBoxOSC/app/src/main/res/drawable/app_banner.png

#背景修改
# mv TVBox/img/bg/app_bg.png TVBoxOSC/app/src/main/res/drawable/app_bg.png

# 主页UI调整 恢复老版；默认多行显示
#cp TVBox/takagen99/xmljava/fragment_user.xml TVBoxOSC/app/src/main/res/layout/fragment_user.xml

# 整体布局修改
#cp TVBox/takagen99/xmljava/BaseActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 主页增加每日一言/去除部分图标
#cp TVBox/takagen99/xmljava/ApiConfig.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
#cp TVBox/takagen99/xmljava/activity_home.xml TVBoxOSC/app/src/main/res/layout/activity_home.xml
#cp TVBox/takagen99/xmljava/HomeActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

# 默认设置修改
#cp TVBox/takagen99/xmljava/App.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/App.java 

# 取消首页从通知栏位置布置
#cp TVBox/takagen99/xmljava/BaseActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 直播添加epg112114支持
#cp TVBox/takagen99/xmljava/LivePlayActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

# 搜索改为爱奇艺热词，支持首字母联想
#cp TVBox/takagen99/xmljava/SearchActivity.java TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java

#长按倍速修改为2
#sed -i 's/3.0/2.0/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#添加详情页播放列表宽度自适
#sed -i '/import me.jessyan.autosize.utils.AutoSizeUtils;/a\import android.graphics.Rect;\nimport android.graphics.Paint;\nimport android.text.TextPaint;\nimport androidx.annotation.NonNull;\nimport android.graphics.Typeface;\nimport androidx.recyclerview.widget.RecyclerView;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/private View seriesFlagFocus = null;/a\    private V7GridLayoutManager mGridViewLayoutMgr = null;' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/mGridView.setLayoutManager(new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7));/mGridView.setHasFixedSize(false);\n        this.mGridViewLayoutMgr = new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7);\n        mGridView.setLayoutManager(this.mGridViewLayoutMgr);\n/g' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/seriesAdapter.setNewData(vodInfo.seriesMap.get(vodInfo.playFlag));/i\        Paint pFont = new Paint();\n        Rect rect = new Rect();\n        List<VodInfo.VodSeries> list = vodInfo.seriesMap.get(vodInfo.playFlag);\n        int w = 1;\n        for(int i =0; i < list.size(); ++i){\n            String name = list.get(i).name;\n            pFont.getTextBounds(name, 0, name.length(), rect);\n            if(w < rect.width()){\n                w = rect.width();\n            }\n        }\n        w += 32;\n        int screenWidth = getWindowManager().getDefaultDisplay().getWidth()\/3;\n        int offset = screenWidth\/w;\n        if(offset <=1) offset =1;\n        if(offset > 6) offset =6;\n        this.mGridViewLayoutMgr.setSpanCount(offset);\n' $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/FrameLayout/LinearLayout/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
#sed -i 's/width=\"wrap_content\"/width=\"match_parent\"/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml
#sed -i 's/@dimen\/vs_190/match_parent/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/item_series.xml

#FongMi的jar支持
#echo "" >> TVBoxOSC/app/proguard-rules.pro
#echo "-keep class com.google.gson.**{*;}" >> TVBoxOSC/app/proguard-rules.pro
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
echo '添加arm64-v8a完成'
EOF
chmod +x ./arm64-v8a.sh

#添加add-X86
touch ./add-X86.sh
cat << 'EOF' > ./add-X86.sh
#!/bin/bash
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'x86', 'x86_64'#" TVBoxOSC/app/build.gradle
echo '添加add-X86完成'
EOF
chmod +x ./add-X86.sh

# echo "javaVersion=17" >> $GITHUB_ENV
