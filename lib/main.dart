import 'package:decentralized_wallet_app/auth_page/auth_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
     home: FutureBuilder(future: isLoggedIn(), builder: (context, snapshot){
        return AuthPage();
      }),
    );
  }

  Future<int> isLoggedIn() async{
    return 1;
  }
}