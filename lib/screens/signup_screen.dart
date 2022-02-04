import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpinghands/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Form(
        child: Column(
          children: <Widget>[
            const Text('Sign Up'),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SignInScreen();
                }));
              },
            ),
            TextButton(
              child: const Text('Already Register, then Sign In'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SignInScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
