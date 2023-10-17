import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOGIN')),
      body: const Center(
        child: Column(
          children: [
            Text('LOGIN',
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue
            ),)
          ]
          ),
      ),
    );
  }



}