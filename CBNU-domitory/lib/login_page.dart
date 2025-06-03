import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap; // 회원가입 페이지로 전환하는 함수

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // 로그인 시도 함수
  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // 이전 에러 메시지 초기화
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // 로그인 성공 시 AuthGate가 자동으로 HomePage로 이동시킴
    } on FirebaseAuthException catch (e) {
      // 흔한 오류 코드에 대한 사용자 친화적 메시지
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = '등록되지 않은 이메일입니다.';
          break;
        case 'wrong-password':
          message = '비밀번호가 틀렸습니다.';
          break;
        case 'invalid-email':
          message = '유효하지 않은 이메일 형식입니다.';
          break;
        case 'user-disabled':
          message = '비활성화된 계정입니다.';
          break;
        default:
          message = '로그인 중 오류가 발생했습니다: ${e.message}';
      }
      setState(() {
        _errorMessage = message;
      });
      print('Login failed: ${e.code} - ${e.message}'); // 디버깅용 로그
    } catch (e) {
      // 기타 예상치 못한 오류
      setState(() {
        _errorMessage = '알 수 없는 오류가 발생했습니다.';
      });
      print('An unexpected error occurred: $e'); // 디버깅용 로그
    } finally {
      if (mounted) { // 위젯이 여전히 트리에 있는지 확인
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // 키보드가 올라올 때 화면 깨짐 방지
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 80),
                const SizedBox(height: 30),
                const Text('환영합니다!', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 30),

                // 이메일 필드
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // 비밀번호 필드
                TextField(
                  controller: _passwordController,
                  obscureText: true, // 비밀번호 가리기
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 10),

                // 에러 메시지 표시
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 20),

                // 로그인 버튼
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('로그인', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),

                // 회원가입 페이지로 이동
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 없으신가요?'),
                    TextButton(
                      onPressed: widget.onTap, // 전달받은 함수 호출
                      child: const Text(
                        '회원가입',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}