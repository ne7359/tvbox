#!/bin/bash

echo '添加PY支持'
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O TVBoxOSC/app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" TVBoxOSC/app/build.gradle
sed -i 's#@#\\#g' TVBoxOSC/app/build.gradle
sed -i 's#pyramid#\\pyramid#g' TVBoxOSC/app/build.gradle
echo "" >> TVBoxOSC/app/proguard-rules.pro
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
