import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<TransferEvent>((event, emit) async {
      try {
        print('transfer');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final http.Response response = await http.post(
            Uri.parse("http://10.201.197.234:5000/wallet/auth/verify/verify_user/transfer"),
            body: jsonEncode(
                {"amount": event.amount, "recipient": event.reciever.toString()}),
            headers: {
              'Content-Type': 'application/json',
              'authorization': prefs.getString('token')!,
              'address': prefs.getString('address')!
            });
        if (response.statusCode == 200) {
          final balance = await getBalance(prefs);
          print("balance $balance");
          emit(
            GotBalanceState(
              balance: balance,
            ),
          );
        }
        else{
          print(response.body);
        }
      } catch (err) {
        print(err);
        emit(
          TransferErrorState(
            error: err.toString(),
          ),
        );
      }
    });
    on<GetBalanceEvent>((event, emit) async {
      try {
        print('getbalance');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final balance = await getBalance(prefs);
        print("balance $balance");
        emit(
          GotBalanceState(
            balance: balance,
          ),
        );
      } catch (err) {
        print(err.toString());
        emit(
          TransferErrorState(
            error: err.toString(),
          ),
        );
      }
    });
  }

  Future<int> getBalance(SharedPreferences prefs) async {
    final res = await http.get(
        Uri.parse(
          'http://10.201.197.234:5000/wallet/auth/verify/get_balance',
        ),
        headers: {
          'Content-Type': 'appication/json',
          'authorization': prefs.getString('token')!,
          'address': prefs.getString('address')!
        });
    final balance = int.parse(jsonDecode(res.body)['balance']);
    return balance;
  }
}
