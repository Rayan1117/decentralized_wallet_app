part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// ignore: must_be_immutable
final class LoginEvent extends AuthEvent {
  GlobalKey<FormState> formkey;
  String email;
  String password;
  LoginEvent(
      {required this.formkey, required this.email, required this.password});
}

// ignore: must_be_immutable
final class RegisterEvent extends AuthEvent {
  GlobalKey<FormState> formkey;
  String email;
  String password;
  String username;
  RegisterEvent(
      {required this.email,
      required this.formkey,
      required this.password,
      required this.username});
}
