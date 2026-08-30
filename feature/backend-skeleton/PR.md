# PR 描述 — feature/backend-skeleton -> main

标题：feat: backend skeleton + demo (SMS stub, consult API, docs)

变更说明：
- 添加最小可运行后端示例（Express），包含发送/校验短信（stub）、JWT 登录、问诊创建、医生列表等接口示例。  
- 添加 Postgres 建表脚本（schema.sql）与 Flutter 调用示例。  
- 新增 docker-compose.yml 以便本地快速启动示例环境（包含 postgres、backend 服务）。

运行说明（本地快速启动）：
1. 克隆仓库并切换到该分支：
   git clone https://github.com/luffy990420/- && cd -
   git checkout feature/backend-skeleton
2. 进入 backend 目录并安装依赖：
   cd feature/backend-skeleton/backend
   npm install
3. 启动依赖服务（docker-compose）
   docker-compose -f ../docker-compose.yml up -d
4. 启动后端服务：
   node index.js
5. 示例 API：
   - POST /api/auth/send-sms
   - POST /api/auth/verify-sms
   - GET /api/doctors
   - POST /api/consults

注意事项：
- 该示例使用内存存储验证码，仅用于本地联调；生产环境需接入腾讯云短信、持久化数据库与对象存储。  
- 若你希望我直接为该分支打开 Pull Request（将分支合并到 main），回复“请打开 PR”，我将继续创建 PR 并在描述中附上运行截图与联调清单。
