import 'package:ecommerce/components/my_button.dart';
import 'package:ecommerce/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotpasswordPageState createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Set a Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Please create a secure password including the following criteria below.",
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.grey.shade600),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Email Textfield
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Passowrd Textfield
                TextField(
                  onChanged: (password) => onPasswordChanged(password),
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    hintText: "Password",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //  Confirm Password
                TextField(
                  onChanged: (password) => onPasswordChanged(password),
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    hintText: "Confirm Password",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: _isPasswordEightCharacters
                              ? Colors.green
                              : Colors.transparent,
                          border: _isPasswordEightCharacters
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Contains at least 8 characters")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: _hasPasswordOneNumber
                              ? Colors.green
                              : Colors.transparent,
                          border: _hasPasswordOneNumber
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Contains at least 1 number")
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    onTap: () => Navigator.pushNamed(context, '/login_page'),
                    text: "SUBMIT",

                    child: const Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:ecommerce/components/my_button.dart';
// import 'package:ecommerce/components/my_textfield.dart';
// import 'package:flutter/material.dart';

// class ForgotpasswordPage extends StatelessWidget {
//   // text controllers
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//    final TextEditingController confirmpasswordController = TextEditingController();

//   ForgotpasswordPage({super.key});

//   // login method
//   void login() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //   logo
//                 Icon(
//                   Icons.person,
//                   size: 80,
//                   color: Theme.of(context).colorScheme.inversePrimary,
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //   app name
//                 const Text(
//                   "M I N I M A L",
//                   style: TextStyle(fontSize: 20),
//                 ),

//                 const SizedBox(
//                   height: 50,
//                 ),

//                 //   emailtextfield
//                 MyTextField(
//                   hintText: "Email",
//                   obscureText: false,
//                   controller: emailController,
//                 ),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 //   new password textfield
//                 MyTextField(
//                   hintText: " New Password",
//                   obscureText: true,
//                   controller: passwordController,
//                 ),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 MyTextField(
//                   hintText: "Confirm Password",
//                   obscureText: true,
//                   controller: passwordController,
//                 ),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //   update password button
//                 MyButton(
//                   text: "Update",
//                   onTap: () => Navigator.pushNamed(context, '/login_page'),
//                   child: Text(""),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),
//               ],
//             ),
//           ),  
//         ),
//       ),
//     );
//   }
// }
