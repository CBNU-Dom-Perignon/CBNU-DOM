import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // flutterfire configure 실행 후 생성됨
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_gate.dart';

void main() async {
  // Flutter 엔진과 위젯 바인딩 초기화 보장
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 앱 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // firebase_options.dart 사용
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 인증 상태에 따라 다른 화면을 보여줄 위젯
      home: const AuthGate(),
    );
  }
}