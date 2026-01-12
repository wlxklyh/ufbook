#!/bin/bash

echo "========================================"
echo "  UF Book - 部署到腾讯云 CloudBase"
echo "========================================"
echo ""

# 检查是否已安装 MkDocs
if ! command -v mkdocs &> /dev/null; then
    echo "[错误] 未检测到 MkDocs！"
    echo ""
    echo "请先安装依赖："
    echo "  pip install -r requirements.txt"
    exit 1
fi

# 检查是否已安装 CloudBase CLI
if ! command -v tcb &> /dev/null; then
    echo "[错误] 未检测到 CloudBase CLI！"
    echo ""
    echo "请先安装 CloudBase CLI："
    echo "  npm install -g @cloudbase/cli"
    echo ""
    echo "或访问：https://docs.cloudbase.net/cli-v1/intro"
    exit 1
fi

echo "[提示] 此脚本将："
echo "  1. 构建静态网站"
echo "  2. 部署到 CloudBase 静态网站托管"
echo ""
echo "请确保已："
echo "  - 登录 CloudBase CLI (tcb login)"
echo "  - 选择正确的环境"
echo ""
read -p "确认继续？(y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo "[构建] 正在构建网站..."
mkdocs build --clean

if [ $? -ne 0 ]; then
    echo "[错误] 构建失败！"
    exit 1
fi

echo ""
echo "[检查] 检查 CloudBase 登录状态..."
tcb env:list > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[提示] 需要先登录 CloudBase"
    echo ""
    echo "请执行："
    echo "  tcb login"
    echo ""
    echo "然后重新运行此脚本"
    exit 1
fi

echo ""
echo "[部署] 正在部署到 CloudBase..."
echo ""

# 部署到 CloudBase 静态网站托管
if [ -z "$CLOUDBASE_ENV_ID" ]; then
    echo "[错误] 未设置环境 ID"
    echo ""
    echo "请设置环境变量："
    echo "  export CLOUDBASE_ENV_ID=your-env-id"
    echo ""
    echo "或使用 -e 参数："
    echo "  tcb hosting:deploy site/ -e your-env-id"
    exit 1
fi

tcb hosting:deploy site/ -e "$CLOUDBASE_ENV_ID"

if [ $? -ne 0 ]; then
    echo ""
    echo "[错误] 部署失败！"
    echo ""
    echo "可能的原因："
    echo "1. 未设置环境 ID"
    echo "2. 未登录 CloudBase CLI"
    echo "3. 没有部署权限"
    echo ""
    echo "手动部署步骤："
    echo "1. tcb login"
    echo "2. tcb env:list （查看环境列表）"
    echo "3. export CLOUDBASE_ENV_ID=your-env-id"
    echo "4. tcb hosting:deploy site/ -e your-env-id"
    exit 1
fi

echo ""
echo "========================================"
echo "  ✓ 部署成功！"
echo "========================================"
echo ""
echo "你的网站已部署到 CloudBase"
echo ""
echo "提示："
echo "- 访问地址可在 CloudBase 控制台查看"
echo "- 可以绑定自定义域名"
echo "- 支持 HTTPS 和 CDN 加速"
echo ""

