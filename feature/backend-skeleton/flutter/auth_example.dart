// flutter/auth_example.dart
// Flutter 调用示例（使用 http 包）

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendSms(String phone) async {
  final res = await http.post(
    Uri.parse('https://api.yourdomain.com/api/auth/send-sms'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'phone': phone}),
  );
  if (res.statusCode == 200) print('sms sent');
}

Future<String?> verifySms(String phone, String code) async {
  final res = await http.post(
    Uri.parse('https://api.yourdomain.com/api/auth/verify-sms'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'phone': phone, 'code': code}),
  );
  if (res.statusCode == 200) {
    final body = jsonDecode(res.body);
    return body['token'];
  }
  return null;
}
