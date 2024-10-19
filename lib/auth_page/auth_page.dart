import 'package:decentralized_wallet_app/auth_bloc/auth_bloc.dart';
import 'package:decentralized_wallet_app/auth_page/login_page.dart';
import 'package:decentralized_wallet_app/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
