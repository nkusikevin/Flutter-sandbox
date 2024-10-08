import 'package:flutter/material.dart';
import 'package:food_order/components/custom_button.dart';
import 'package:food_order/components/custom_input.dart';
import 'package:food_order/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() {
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fastfood,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 20),
            Text(
              "Yammy Pozo",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            CustomInput(
              controller: emailController,
              hintText: "Email",
            ),
            const SizedBox(height: 10),
            CustomInput(
              controller: passwordController,
              hintText: "password",
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Login",
              onTap: () {
                print("Email: ${emailController.text}");
                print("Password: ${passwordController.text}");
                login();
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onTap!();
                  },
                  child: TextButton(
                    onPressed: () {
                      widget.onTap!();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
