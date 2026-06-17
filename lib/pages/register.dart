import 'package:ecommerce_app1/components/button.dart';
import 'package:ecommerce_app1/components/custom_texfield.dart';
import 'package:ecommerce_app1/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  Future<void> register() async {
    final authService = AuthService();

    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      try {
        await authService.signUpWithEmailPassword(
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
    } else {
      if (!mounted) return;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Passwords do not match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Register Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.lock,
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
            SizedBox(height: 16),
            CustomTextField(
              controller: confirmpasswordcontroller,
              hintText: "confirm password",
              obscureText: true,
            ),
            SizedBox(height: 24),
            MyButton(
              onTap: () {
                register();
              },
              text: 'Sign Up',
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text("Already have an Account"),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
