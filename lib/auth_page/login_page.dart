import 'package:decentralized_wallet_app/auth_bloc/auth_bloc.dart';
import 'package:decentralized_wallet_app/auth_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        (state is LoggedInState)
            ? Navigator.pushNamed(context, '/homepage')
            : null;
        (state is AuthErrorState)
            ? ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              )
            : null;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0xffECFAFF),
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            formkey: _formkey,
                            email: _emailController.text,
                            password: _passwordController.text));
                      },
                      child: Container(
                        height: 40,
                        width: 180,
                        decoration: const BoxDecoration(
                          color: Color(0xffFBCF84),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Center(
                          child: Text('Sign In'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  color: Color(0xff1E355F),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 150, 50, 25),
                  decoration: const BoxDecoration(
                    color: Color(0xffFBCF84),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "the email should be entered";
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  label: Text('Email'),
                                  hintText: 'enter your email'),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "the email should be entered";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  label: Text('Password'),
                                  hintText: 'enter your password'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPage();
                              },
                            ),
                          );
                        },
                        child: const Text('Create new account'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
