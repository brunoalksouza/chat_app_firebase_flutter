import 'package:chat_app_firebase_flutter/auth/auth_service.dart';
import 'package:chat_app_firebase_flutter/components/my_button.dart';
import 'package:chat_app_firebase_flutter/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();

    if (passwordController.text == confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senhas não conferem'),
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
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Confirm Password',
              obscure: true,
              controller: confirmPwController,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Já tem um login?'),
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
