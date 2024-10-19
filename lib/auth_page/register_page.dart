import 'package:decentralized_wallet_app/auth_page/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Sign Up')],
            ),
          ),
          Container(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      label: Text('Username'), hintText: 'enter the username'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text('Email'), hintText: 'enter your email'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text('Password'), hintText: 'enter password again'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text('Password'), hintText: 'enter password again'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));
                    }, child: Text('I already have an account'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
