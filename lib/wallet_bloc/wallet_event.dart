part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

final class TransferEvent extends WalletEvent {
  final int amount;
  final String reciever;

  TransferEvent({required this.amount, required this.reciever});
}

final class GetBalanceEvent extends WalletEvent{}