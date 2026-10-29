#!/bin/bash
# cli - one-click install script
# Repo: https://github.com/你的用户名/cli
set -e

# ========== 请替换为你的 GitHub 用户名 ==========
GITHUB_USER="hfzjob"
BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/${GITHUB_USER}/cli/${BRANCH}"
# ================================================

if [ "$(id -u)" -ne 0 ];then
    echo "❌ 必须以 root 运行: sudo bash install.sh"
    exit 1
fi

echo "===== Cli Port Hopping Manager 安装开始 ====="

# 1. 安装基础依赖
echo "1. 检查并安装依赖 (iptables, curl, ufw)..."
apt update -qq
apt install -y -qq iptables curl ufw

# 2. 下载主程序到全局路径
echo "2. 下载 cli 主程序到 /usr/local/bin/cli"
curl -fsSL "${RAW_BASE}/cli" -o /usr/local/bin/cli
chmod +x /usr/local/bin/cli

# 3. 创建配置目录
mkdir -p /etc/cli

# 4. 安装 systemd 自启服务
echo "3. 安装 systemd 开机自启服务"
curl -fsSL "${RAW_BASE}/cli.service" -o /etc/systemd/system/cli.service
systemctl daemon-reload
systemctl enable cli

echo
echo "✅ 安装完成！"
echo "全局命令: cli"
echo "查看帮助: cli help"
echo "示例添加: sudo cli add 443 55000 60000"
echo
echo "💡 开机自动加载已保存的规则，无常驻后台进程"
