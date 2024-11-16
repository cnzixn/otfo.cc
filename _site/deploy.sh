#!/bin/bash

# cd /sdcard/acode/otfo.cc/
# bash deploy.sh

# 网页子目录
dir="bny"

# 设置远端仓库
# git remote set-url origin https://github.com/cnzixn/otfo.cc.git

# 新建一个本地仓库，并设置远端仓库
# git init
# git remote add origin https://github.com/cnzixn/otfo.cc.git
# 当前仓库为 master 才能执行下面代码
# git branch

# 切换到主分支，构建站点并提交更改
git checkout -b master
git checkout master
jekyll build
git add .
git commit -m "Update master"
git push origin master --force

# 切换到 gh-pages 分支，清空内容
git checkout -b gh-pages
git checkout gh-pages
git rm -rf .

# 将 _site 文件夹内容复制到 gh-pages 分支根目录
git checkout main -- CNAME
git checkout main -- .gitignore
git checkout main -- _site
git checkout main -- search.json
cp -r ./_site ./"$dir"
cp -r ./"$dir"/s .
# cp ./"$dir"/index.html .
cp ./"$dir"/404.html .

# 提交并推送到 gh-pages 分支
git add .
git reset deploy.sh
git reset start.sh
git commit -m "Deploy gh-pages"
git push origin gh-pages --force

# 返回到主分支
git checkout main
rm -rf ./"$dir"
git add .
git commit -m "Update gh-pages"

