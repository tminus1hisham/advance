import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real app, you would validate credentials here
      if (event.identifier.isNotEmpty && event.pin.isNotEmpty) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('Invalid credentials'));
      }
    });

    on<LogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
