import 'package:chat_app_firebase_flutter/auth/auth_service.dart';
import 'package:chat_app_firebase_flutter/components/my_button.dart';
import 'package:chat_app_firebase_flutter/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Center(
            child: Text('Informações inválidas'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Text('Seja bem vindo de volta'),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Email',
              obscure: false,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Password',
              obscure: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Não tem login?'),
              GestureDetector(
                onTap: onTap,
                child: const Text(
                  ' Se registre!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
