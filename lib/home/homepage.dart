import 'package:decentralized_wallet_app/wallet_bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WalletBloc>(context).add(GetBalanceEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (context, state) {
          (state is TransferErrorState)
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                )
              : null;
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    (state is GotBalanceState)
                        ? state.balance.toString()
                        : "no data",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                    label: Text('Address'),
                                    hintText: "enter the reciever's address"),
                              ),
                              TextField(
                                controller: _amountController,
                                decoration: const InputDecoration(
                                    label: Text('Amount'),
                                    hintText:
                                        'enter the amount you want to transfer'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<WalletBloc>(context).add(
                                    TransferEvent(
                                      amount: int.parse(_amountController.text),
                                      reciever:
                                          _addressController.text.toString(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Transfer",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text('transfer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
