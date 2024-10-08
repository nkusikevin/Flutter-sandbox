import 'package:flutter/material.dart';
import 'package:food_order/components/custom_button.dart';
import 'package:food_order/components/custom_input.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

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
            CustomInput(
              controller: ConfirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Sign Up",
              onTap: () {
                print("Email: ${emailController.text}");
                print("Password: ${passwordController.text}");
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: TextButton(
                    onPressed: () {
                      widget.onTap!();
                    },
                    child: Text(
                      "Sign In",
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
