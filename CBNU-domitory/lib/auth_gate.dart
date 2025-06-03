import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_or_register_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // FirebaseAuth의 인증 상태 변경 스트림을 구독
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 로딩 중일 때 (연결 대기)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 사용자가 로그인한 경우
          if (snapshot.hasData) {
            // HomePage 표시
            return HomePage();
          }
          // 사용자가 로그인하지 않은 경우
          else {
            // LoginPage 또는 RegisterPage를 선택하는 페이지 표시
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}