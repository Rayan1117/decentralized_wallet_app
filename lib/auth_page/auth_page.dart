import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final GlobalKey _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xffECFAFF),
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Color(0xffFBCF84),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        child: Text('Sign In'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 700,
            decoration: BoxDecoration(
              color: Color(0xff1E355F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 200, 50, 200),
              decoration: BoxDecoration(
                  color: Color(0xffFBCF84),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                label: Text('Email'),
                                hintText: 'enter your email'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                label: Text('Password'),
                                hintText: 'enter your password'),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
