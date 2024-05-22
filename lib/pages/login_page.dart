import 'dart:convert';

import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/my_textfield.dart';
import 'package:ecommerce/pages/shop_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String EMAILKEY = "email";
  static const String PASSKEY = "password";
  static const String LOGIN = "isLoggedIn";
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String? savedEmail;

  String? savedPassword;

  bool _isLogginIn = false;

  // login method
  void _login() async {
    setState(() {
      _isLogginIn = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEmail = prefs.getString(EMAILKEY);
    savedPassword = prefs.getString(PASSKEY);

    // Validate email format
    if (!EmailValidator.validate(emailController.text.trim())) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Email"),
          content: const Text("Please enter a valid email address"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      setState(() {
        _isLogginIn = false;
      });
      return;
    }

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Credentials Missing"),
          content: const Text("Enter Your Email & Password"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else if (savedEmail != null && savedPassword != null) {
      if (emailController.text == savedEmail &&
          passwordController.text == savedPassword) {
        //   Login successful (navigate to next page or show success message)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShopPage()),
        );
        print('Login successful using saved credentials.');
      }
      // it was else if
      if (emailController.text != savedEmail &&
          passwordController.text != savedPassword) {
        //  NO saved Credentials
        try {
          final response = await http.post(
            Uri.parse('https://ecommercebackend-x2kr.onrender.com/user/login'),
            body: jsonEncode({
              'email': emailController.text,
              'password': passwordController.text,
            }),
            headers: {'Content-Type': 'application/json'},
          );
          if (response.statusCode == 200) {
            var prefs = await SharedPreferences.getInstance();
            prefs.setString(EMAILKEY, emailController.text);
            prefs.setString(PASSKEY, passwordController.text);
            prefs.setBool(LOGIN, true);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopPage()),
            );
            print('Login Using API');
          } else {
            print('Login failed with status code: ${response.statusCode}');
          }
        } catch (error) {
          print('Error: $error');
        }
      }
    } else {
      try {
        final response = await http.post(
          Uri.parse('https://ecommercebackend-x2kr.onrender.com/user/login'),
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
          }),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString(EMAILKEY, emailController.text);
          prefs.setString(PASSKEY, passwordController.text);
          prefs.setBool(LOGIN, true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShopPage()),
          );
          print('Login Using API');
        } else {
          print('Login failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
    setState(() {
      _isLogginIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
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

                //   emailtextfield
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(
                  height: 10,
                ),

                //   password textfield
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 10,
                ),

                //   forgot text-field
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forgotpassword_page'),
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                //   sign in button
                MyButton(
                  text: "Login",
                  onTap: _isLogginIn ? null : _login,
                  child: const Text("Login"),
                ),

                const SizedBox(
                  height: 25,
                ),

                //   don't have account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?   ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/register_page'),
                      child: const Text(
                        "Register Here",
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
