#!/bin/bash

sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'x86', 'x86_64'#" TVBoxOSC/app/build.gradle
sed -i "/armeabi-v7a[\'\"]$/s#\$#, 'x86', 'x86_64'#" TVBoxOSC/app/player/build.gradle
echo '添加x86支持完成'
