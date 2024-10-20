import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        print("event triggered");
        if (event.formkey.currentState!.validate()) {
          final response = await http
              .post(Uri.parse("http://192.168.213.45:5000/auth/login"),
                  body: jsonEncode(
                    {"email": event.email, "password": event.password},
                  ),
                  headers: {"Content-Type": "application/json"});
          if (response.statusCode == 200) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final decoded = jsonDecode(response.body);
            final token = decoded['message']['token'].toString();
            final address = decoded['message']['address'].toString();
            print("$token $address");
            prefs.setString('address', address);
            prefs.setString('token', token);
            print('logged in successfully');
            emit(
              LoggedInState(),
            );
          } else {
            emit(
              AuthErrorState(
                error: jsonDecode(response.body)['error'].toString(),
              ),
            );
          }
        }
      } catch (err) {
        print(err.toString());
        emit(
          AuthErrorState(
            error: err.toString(),
          ),
        );
      }
    });

    on<RegisterEvent>((event, emit) async {
      try {
        if (event.formkey.currentState!.validate()) {
          final response = await http.post(
            Uri.parse("http://192.168.213.45:5000/auth/register"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
              {
                "username": event.username,
                "email": event.email,
                "password": event.password
              },
            ),
          );
          if (response.statusCode == 200) {
            add(
              LoginEvent(
                  formkey: event.formkey,
                  email: event.email,
                  password: event.password),
            );
          }
        }
      } catch (err) {
        print(err);
        emit(
          AuthErrorState(
            error: err.toString(),
          ),
        );
      }
    });
  }
}
