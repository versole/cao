# CAO 命令行工具

## 介绍
CAO 是一个命令行工具，根据用户描述直接获取相应的命令。就是简单调了个chatgpt api, 灵感来源[thefuck](https://github.com/nvbn/thefuck)

## 安装
```bash
curl -o- https://raw.githubusercontent.com/versole/cao/master/install.sh | bash

source <your-shell-profile-file> #~/.zshrc   ~/.bashrc ...
```


## 配置
具体的openai api key与调用url需要手动设置

这里有绑定github可以获取免费的api_key 与 调用url, 每天100次的免费调用（3.5 turbo）[chatanywhere](https://github.com/chatanywhere/GPT_API_free)

```bash
cao set key <你的api密钥>
cao set url <你的api-url>
```
## 使用方法
基于描述询问特定命令：

``` bash
cao q <你想要执行的操作>
```

例如，要了解如何列出 Git 中的所有分支：
``` bash
cao q git怎么查看所有分支
```


## 命令概览

- `cao set key <api-key>`: 保存你的 API 密钥。
  -  例如：`cao set key 12345678-1234-1234-1234-123456789012`
- `cao set url <api-url>`: 保存 API 端点 URL。
  -  例如，`cao set url https://api.openai.com/v1/chat/completions`
- `cao q <你的需求>`: 描述任务或问题，CAO 将提供具体的命令。

## 注意

确保你正确设置了 API 密钥和 API URL，然后使用 CAO 来询问命令。






