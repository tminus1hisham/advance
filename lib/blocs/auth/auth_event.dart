part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String identifier;
  final String pin;

  const LoginRequested({required this.identifier, required this.pin});

  @override
  List<Object> get props => [identifier, pin];
}

class LogoutRequested extends AuthEvent {}
