import 'dart:convert';

import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmpasswordController =
      TextEditingController();

  String? _errorMessage;

  // register method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //   logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(
                  height: 25,
                ),

                //   app name
                const Text(
                  "M I N I M A L",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(
                  height: 50,
                ),

                //   email text-field
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hintText: "Email",
                        obscureText: false,
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                //   password text-field
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 10,
                ),

                //   confirm password text-field
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmpasswordController,
                ),

                const SizedBox(
                  height: 10,
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                //   register button
                MyButton(
                  text: "Register",
                  onTap: () async {
                    try {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmpasswordController.text.isNotEmpty) {
                        if (passwordController.text ==
                            confirmpasswordController.text) {
                          final response = await http.post(
                            Uri.parse(
                                'https://ecommercebackend-x2kr.onrender.com/user/register'),
                            body: jsonEncode({
                              "email": emailController.text,
                              "password": passwordController.text,
                            }),
                            headers: {'Content-Type': 'application/json'},
                          );
                          if (response.statusCode == 200) {
                            Navigator.pushReplacementNamed(
                                context, '/login_page');
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Mismatch"),
                                    content: const Text("Check Password"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"))
                                    ],
                                  ));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text("Credintals Missing"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"))
                                  ],
                                ));
                      }
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: const Text("Login"),
                ),

                const SizedBox(
                  height: 25,
                ),

                //   already have a account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?    ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login_page'),
                      child: const Text(
                        "Login Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
