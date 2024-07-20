import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  if (emailController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please input email!'),
                    ));
                    return;
                  }

                  if (passwordController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please input password!'),
                    ));
                    return;
                  }

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);

                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
