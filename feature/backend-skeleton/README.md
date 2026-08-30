# 后端骨架与示例（feature/backend-skeleton 分支）

此分支包含最小可运行的 Node.js/Express 后端示例、Postgres 建表脚本及 Flutter 调用示例，用于与首批 P0 issues 联调与参考实现。

包含文件：
- backend/index.js（Express 示例，含短信验证码 stub、登录、提交问诊接口）
- backend/package.json（示例依赖）
- db/schema.sql（Postgres 建表示例）
- flutter/auth_example.dart（Flutter 请求示例）
- API_DOC.md（中文接口说明）

说明：示例使用内存存储验证码、内存返回示例数据。上线时需替换为真实的数据库、短信服务（腾讯云 SMS）、文件存储（腾讯 COS）、JWT 密钥与微信/支付接入。
