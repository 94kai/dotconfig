# 远程脚本启动器

这是一个简单的 Linux 脚本分发项目。

目录说明：

- `bootstrap.sh`：入口脚本，启动时会拉取远端 `manifest.txt`
- `manifest.txt`：清单文件，定义有哪些可选子脚本
- `publish.sh`：发布脚本，用来把当前项目里的脚本发布到远端
- `scripts/`：子脚本目录
- `serve.sh`：本地临时启动一个 HTTP 服务，方便先用 URL 调试

## 新增脚本

scripts下新增脚本，在manifest中配置，然后发布

## 本地测试

先在当前目录启动本地文件服务（模拟脚本上传后可通过baseUrl下载脚本）：

```bash
bash serve.sh
```

再执行入口脚本：

```bash
baseurl=http://127.0.0.1:8000; curl -fsSL "$baseurl/bootstrap.sh" | bash -s -- "$baseurl"
```

## 发布

使用publish.sh发布脚本，具体看publish.sh


## 使用
baseurl为发布脚本到baseurl，脚本下载url需为baseurl/scripts/脚本名
baseurl=http://127.0.0.1:8000; curl -fsSL "$baseurl/bootstrap.sh" | bash -s -- "$baseurl"
