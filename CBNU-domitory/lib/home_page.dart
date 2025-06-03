import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // 현재 로그인된 사용자 가져오기
  final User? user = FirebaseAuth.instance.currentUser;

  // 로그아웃 함수
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // 로그아웃 성공 시 AuthGate가 자동으로 LoginPage로 이동시킴
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          // 로그아웃 버튼
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '로그인되었습니다!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // 사용자 이메일 표시 (null 체크 포함)
            Text(
              '사용자 이메일: ${user?.email ?? '정보 없음'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}