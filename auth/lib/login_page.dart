import 'package:auth/components/custom_button.dart';
import 'package:auth/components/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Ionicons.lock_closed, size: 50),
                const SizedBox(height: 20),
                const Text('Welcome back!',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                CustomInput(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 20),
                CustomInput(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot password?',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    title: 'Login',
                    onPressed: () {
                      print('Email: ${emailController.text}');
                      print('Password: ${passwordController.text}');
                    }),
                const SizedBox(height: 50),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Or continue with',
                              style: TextStyle(color: Colors.grey[600])),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ],
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          icon: const Icon(Ionicons.logo_google),
                          iconSize: 40,
                          onPressed: () {
                            print('Google');
                          }),
                    ),
                   
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                      child: IconButton(
                          icon: const Icon(Ionicons.logo_apple),
                          iconSize: 40,
                          onPressed: () {
                            print('Apple');
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[600])),
                    TextButton(
                        onPressed: () {
                          print('Sign up');
                        },
                        child: const Text('Sign up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
