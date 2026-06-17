import 'package:ecommerce_app1/components/button.dart';
import 'package:ecommerce_app1/components/custom_texfield.dart';
import 'package:ecommerce_app1/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          emailcontroller.text, passwordcontroller.text);

      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.lock_open_rounded,
                size: 100, color: Theme.of(context).colorScheme.primary),
            CustomTextField(
              controller: emailcontroller,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: passwordcontroller,
              hintText: "password",
              obscureText: true,
            ),
            SizedBox(height: 24),
            MyButton(
              onTap: login,
              text: 'Sign In',
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text("Dont have an Account"),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
