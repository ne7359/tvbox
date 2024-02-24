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
#主界面首页文字修改
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/res/layout/item_home_sort.xml
sed -i 's/color_BBFFFFFF/color_FFFFFF/g' TVBoxOSC/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

#进度条颜色
sed -i 's/color_353744/color_1890FF/g' TVBoxOSC/app/src/main/res/drawable/shape_player_control_vod_seek.xml
EOF
chmod +x ./custom.sh
