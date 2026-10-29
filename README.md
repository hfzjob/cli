# cli
# cli - Hysteria2 Port Hopping Iptables Manager
轻量级 iptables NAT 端口跳转规则管理工具，专为 Hysteria2 端口跳跃（Port Hopping）场景设计。

> ⚠️ 免责声明：本项目仅用于 Linux 网络技术学习。在中国大陆境内搭建翻墙代理属于违法行为，请勿在国内服务器部署使用。

## ✨ 特性
- 全局命令 `cli`，安装后随处可用
- 单条增删、批量清空、持久化保存、开机自启
- 规则带专属标记，**不影响系统原有 iptables 规则**
- 自动端口合法性校验
- 自动兼容 UFW 防火墙，无 UFW 环境自动降级
- systemd oneshot 模式，**无后台常驻进程，零运行时开销**
- 独立规则存储，与系统 iptables-persistent 互不干扰

## 📦 支持系统
Ubuntu 20.04+ / Debian 11+

## 🚀 一键安装
```bash
bash <(curl -Ls https://raw.githubusercontent.com/你的用户名/cli/main/install.sh)

