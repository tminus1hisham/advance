part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String name;
  final String phone;
  final String email;
  final double availableLimit;
  final double outstandingBalance;

  const UserLoaded({
    required this.name,
    required this.phone,
    required this.email,
    required this.availableLimit,
    required this.outstandingBalance,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  List<Object> get props => [name, phone, email, availableLimit, outstandingBalance];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
