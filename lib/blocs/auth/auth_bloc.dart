import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StorageService storageService;

  AuthBloc({required this.storageService}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Short delay to let splash animation play
    await Future.delayed(const Duration(milliseconds: 1500));

    if (storageService.isLoggedIn) {
      emit(AuthAuthenticated(
        name: storageService.userName,
        phone: storageService.userPhone,
      ));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    if (storageService.isLoggedIn) {
      emit(AuthAuthenticated(
        name: storageService.userName,
        phone: storageService.userPhone,
      ));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (event.identifier.isNotEmpty && event.pin.isNotEmpty) {
      // Simulate a successful login – derive a display name from the identifier
      final displayName = 'Jane Doe';
      final phone = event.identifier;

      await storageService.saveSession(
        name: displayName,
        phone: phone,
        email: 'jane.doe@email.com',
        token: 'demo_token_${DateTime.now().millisecondsSinceEpoch}',
      );

      emit(AuthAuthenticated(name: displayName, phone: phone));
    } else {
      emit(const AuthError('Invalid credentials'));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await storageService.clearSession();
    emit(AuthUnauthenticated());
  }
}
