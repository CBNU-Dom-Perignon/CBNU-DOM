import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // 기본적으로 로그인 페이지 표시
  bool showLoginPage = true;

  // 로그인 <-> 회원가입 페이지 전환 함수
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // 로그인 페이지 표시, 전환 함수 전달
      return LoginPage(onTap: togglePages);
    } else {
      // 회원가입 페이지 표시, 전환 함수 전달
      return RegisterPage(onTap: togglePages);
    }
  }
}