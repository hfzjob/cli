#!/bin/bash
# cli uninstall script
set -e

if [ "$(id -u)" -ne 0 ];then
    echo "❌ 请使用 sudo bash uninstall.sh"
    exit 1
fi

echo "==== 卸载 Cli Port Hopping Manager ===="
echo "⚠️  仅卸载程序与自启服务，已添加的 iptables 规则不会自动删除"
echo "如需清空规则，请先执行: sudo cli clear"
echo

systemctl stop cli 2>/dev/null || true
systemctl disable cli 2>/dev/null || true
rm -f /etc/systemd/system/cli.service
systemctl daemon-reload

rm -f /usr/local/bin/cli
rm -rf /etc/cli

echo "✅ 卸载完成"
