#!/bin/bash

sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'arm64-v8a'#" TVBoxOSC/app/build.gradle
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'arm64-v8a'#" TVBoxOSC/app/player/build.gradle
echo '添加arm64完成'
