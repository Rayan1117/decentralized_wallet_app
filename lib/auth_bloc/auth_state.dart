part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoggedInState extends AuthState {}

final class RegisteredState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
