# API_DOC.md（中文）

此文档为仓库内后端示例的接口说明（简化版），用于前端联调参考。

基础认证：
- 所有需要用户身份的接口需要在请求头中添加 Authorization: Bearer <token>

主要接口：
- POST /api/auth/send-sms
  - 请求体: { phone }
  - 返回: { success: true }

- POST /api/auth/verify-sms
  - 请求体: { phone, code }
  - 返回: { token, user }

- GET /api/doctors
  - 返回医生数组: [{ id, name, hospital, specialties, rating, price }]

- POST /api/consults
  - 需登录
  - 请求体: { doctorId, petId, description, media, price }
  - 返回: { consult }

说明：示例后端为演示用途，生产环境需：
- 使用持久化数据库（Postgres）保存数据
- 使用腾讯云短信 SDK 发送验证码
- 使用腾讯 COS 或其他对象存储保存图片/视频
- 使用正式 JWT_SECRET 并做好密钥管理
- 部署时关注 HTTPS、域名白名单、支付回调等安全配置
