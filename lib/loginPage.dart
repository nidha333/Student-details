import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practies/HomePage.dart';
import 'package:practies/signupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Text errorMessage = const Text("");

  Future _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    if (savedUsername == usernameController.text &&
        savedPassword == passwordController.text) {
      await prefs.setBool("isLoggedIn", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('fill the signup page')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 176, 128, 111),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 106, 91),
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: 'Student ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text: 'Details',
                style: TextStyle(
                    color: Color.fromARGB(255, 106, 40, 15),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))
          ]),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'username name is required';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'username',
                    labelText: 'Enter Username',
                  ),
                ),
                const Gap(20),
                TextFormField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'username name is required';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                    labelText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 140, 102, 88),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Gap(10),
                const Gap(10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signuppage(),
                      ),
                    );
                  },
                  child: const Text("Don't you have an account? Sign Up Here!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
