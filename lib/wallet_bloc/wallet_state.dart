part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}


final class TransferErrorState extends WalletState{
  final String error;

  TransferErrorState({required this.error});
}

final class GotBalanceState extends WalletState{
  final int balance;
  GotBalanceState({required this.balance});
}