import 'package:decentralized_wallet_app/auth_bloc/auth_bloc.dart';
import 'package:decentralized_wallet_app/auth_page/auth_page.dart';
import 'package:decentralized_wallet_app/home/homepage.dart';
import 'package:decentralized_wallet_app/wallet_bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => WalletBloc(),
      )
    ],
    child: const EntryPoint(),
  ));
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/homepage": (context) => const HomePage()},
      home: const AuthPage(),
    );
  }

  Future<int> isLoggedIn() async {
    return 1;
  }
}
