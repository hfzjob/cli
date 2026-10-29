#!/bin/bash
# Cli Port Hopping Manager Installer
GITHUB_USER="hfzjob"
REPO_NAME="cli"
BRANCH="main"

echo "==== Cli Port Hopping Manager 安装开始 ===="

# 1. 安装依赖
echo "1. 检查并安装依赖 (iptables, curl, ufw)..."
apt update -qq
apt install -y iptables curl ufw

# 2. 下载 cli 主程序，优先用 jsdelivr CDN
echo "2. 下载 cli 主程序到 /usr/local/bin/cli"
CDN_URL="https://cdn.jsdelivr.net/gh/${GITHUB_USER}/${REPO_NAME}@${BRANCH}/cli"
curl -L ${CDN_URL} -o /usr/local/bin/cli

# 如果CDN失败，回退到github raw
if [ $? -ne 0 ]; then
    echo "CDN下载失败，切换原生raw源重试..."
    RAW_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/${BRANCH}/cli"
    curl -L ${RAW_URL} -o /usr/local/bin/cli
fi

if [ ! -f "/usr/local/bin/cli" ];then
    echo "❌ cli主程序下载失败！"
    exit 1
fi

chmod +x /usr/local/bin/cli

# 3. 下载systemd服务文件
echo "3. 下载 cli.service 自启文件"
CDN_SERVICE="https://cdn.jsdelivr.net/gh/${GITHUB_USER}/${REPO_NAME}@${BRANCH}/cli.service"
curl -L ${CDN_SERVICE} -o /etc/systemd/system/cli.service
if [ $? -ne 0 ]; then
    RAW_SERVICE="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/${BRANCH}/cli.service"
    curl -L ${RAW_SERVICE} -o /etc/systemd/system/cli.service
fi

# 4. 创建配置目录
mkdir -p /etc/cli

# 5. 加载systemd
systemctl daemon-reload
systemctl enable cli

echo "✅ 安装完成！"
echo "使用方法：直接输入 cli 进入交互式菜单"
cli version
