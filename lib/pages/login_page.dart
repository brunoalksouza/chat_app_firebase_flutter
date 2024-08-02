import 'package:chat_app_firebase_flutter/services/auth/auth_service.dart';
import 'package:chat_app_firebase_flutter/components/my_button.dart';
import 'package:chat_app_firebase_flutter/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailError = '';
  String passwordError = '';

  void login(BuildContext context) async {
    final _auth = AuthService();

    setState(() {
      emailError = validarEmail(emailController.text) ? '' : 'Email inválido';
      passwordError =
          validarSenha(passwordController.text) ? '' : 'Senha inválida';
    });

    if (emailError.isEmpty && passwordError.isEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Informações inválidas'),
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  bool validarEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegExp.hasMatch(email) && email.endsWith('.com');
  }

  bool validarSenha(String senha) {
    return senha.length >= 6;
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
            const Text('Seja bem-vindo de volta'),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Email',
              obscure: false,
              controller: emailController,
              errorText: emailError,
            ),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Password',
              obscure: true,
              controller: passwordController,
              errorText: passwordError,
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
                onTap: widget.onTap,
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
