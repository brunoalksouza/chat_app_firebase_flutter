import 'package:chat_app_firebase_flutter/services/auth/auth_service.dart';
import 'package:chat_app_firebase_flutter/components/my_button.dart';
import 'package:chat_app_firebase_flutter/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();

  String emailError = '';
  String passwordError = '';
  String confirmPwError = '';

  void register(BuildContext context) {
    final _auth = AuthService();

    setState(() {
      emailError = validarEmail(emailController.text) ? '' : 'Email inválido';
      passwordError = validarSenha(passwordController.text)
          ? ''
          : 'A senha deve ter 6 caracteres';
      confirmPwError = passwordController.text == confirmPwController.text
          ? ''
          : 'Senhas não conferem';
    });

    if (emailError.isEmpty && passwordError.isEmpty && confirmPwError.isEmpty) {
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
    }
  }

  bool validarEmail(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegExp.hasMatch(email) && email.endsWith('.com');
  }

  bool validarSenha(String senha) {
    return senha.length == 6;
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
              errorText: emailError,
            ),
            const SizedBox(height: 20),
            MyTextField(
              hintText: 'Password',
              obscure: true,
              controller: passwordController,
              errorText: passwordError,
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: 'Confirm Password',
              obscure: true,
              controller: confirmPwController,
              errorText: confirmPwError,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Registrar',
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Já tem um login?'),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  ' Faça Login!',
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
