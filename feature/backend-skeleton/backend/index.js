// backend/index.js
// 最简后端示例：Express + JWT + 内存验证码（演示用途）
const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
const { v4: uuidv4 } = require('uuid');

const app = express();
app.use(bodyParser.json());

const SMS_STORE = {}; // { phone: { code, expireAt } }
const JWT_SECRET = process.env.JWT_SECRET || 'changeme';

// 发送验证码（示例：生产需调用腾讯云短信）
app.post('/api/auth/send-sms', (req, res) => {
  const { phone } = req.body;
  if (!phone) return res.status(400).json({ error: 'phone required' });
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  SMS_STORE[phone] = { code, expireAt: Date.now() + 5 * 60 * 1000 };
  console.log(`[demo] send sms to ${phone}: code=${code}`);
  // TODO: 调用腾讯云短信 SDK 发送短信
  return res.json({ success: true });
});

app.post('/api/auth/verify-sms', (req, res) => {
  const { phone, code } = req.body;
  const entry = SMS_STORE[phone];
  if (!entry || entry.code !== code || entry.expireAt < Date.now()) {
    return res.status(400).json({ error: 'invalid code' });
  }
  // 在真实系统中：查找或创建用户
  const userId = uuidv4();
  const token = jwt.sign({ sub: userId, phone }, JWT_SECRET, { expiresIn: '30d' });
  return res.json({ token, user: { id: userId, phone } });
});

function authMiddleware(req, res, next) {
  const hdr = req.headers.authorization;
  if (!hdr) return res.status(401).json({ error: 'no token' });
  const token = hdr.split(' ')[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload;
    next();
  } catch (e) {
    return res.status(401).json({ error: 'invalid token' });
  }
}

// 示例：创建问诊工单
app.post('/api/consults', authMiddleware, (req, res) => {
  const { doctorId, petId, description, media, price } = req.body;
  const consultId = uuidv4();
  const consult = {
    id: consultId,
    userId: req.user.sub,
    doctorId,
    petId,
    description,
    media,
    status: 'pending',
    price: price || 0,
    created_at: new Date()
  };
  // TODO: 保存到数据库
  return res.json({ consult });
});

// 示例：医生列表（静态示例）
app.get('/api/doctors', (req, res) => {
  const doctors = [
    { id: 'doc-1', name: '张医生', hospital: '异宠专科1', specialties: ['爬宠'], rating: 4.8, price: 39 },
    { id: 'doc-2', name: '李医生', hospital: '异宠专科2', specialties: ['鸟类','啮齿'], rating: 4.6, price: 29 }
  ];
  return res.json({ doctors });
});

app.listen(3000, () => console.log('API listening on 3000'));
