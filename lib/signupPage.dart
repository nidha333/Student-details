import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practies/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setString("password", password);
    await prefs.setBool("isLoggedIn", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Please Complete all Fields",
        style: TextStyle(color: Colors.red),
      )));
    } else {
      return;
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
                      fontWeight: FontWeight.bold)),
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
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'enter username',
                    ),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'enter password',
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      _signUp(
                          _usernameController.text, _passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 140, 102, 88)),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ));
  }
}
