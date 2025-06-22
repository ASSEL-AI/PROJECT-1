import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'change_password_step2.dart';

class ChangePasswordStep1 extends StatefulWidget {
  const ChangePasswordStep1({super.key});

  @override
  State<ChangePasswordStep1> createState() => _ChangePasswordStep1State();
}

class _ChangePasswordStep1State extends State<ChangePasswordStep1> {
  final _controller = TextEditingController();
  final supabase = Supabase.instance.client;
  bool _loading = false;
  String? _errorMessage;

  Future<void> _verifyPassword() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final user = supabase.auth.currentUser;
    final email = user?.email;
    final password = _controller.text.trim();

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email!,
        password: password,
      );

      if (response.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChangePasswordStep2()),
        );
      } else {
        setState(() => _errorMessage = 'كلمة المرور غير صحيحة');
      }
    } catch (e) {
      setState(() => _errorMessage = 'كلمة المرور غير صحيحة');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C180),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Icon(Icons.person, size: 80, color: Colors.white),
          const Text("Mohammed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'ادخل كلمة المرور القديمة',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_errorMessage != null)
                    Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: _loading ? null : _verifyPassword,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C180)),
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('متابعة', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('رجوع', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}