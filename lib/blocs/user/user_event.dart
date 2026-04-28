part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends UserEvent {}

class UpdateUserProfile extends UserEvent {
  final String? name;
  final String? phone;
  final String? email;

  const UpdateUserProfile({this.name, this.phone, this.email});

  @override
  List<Object> get props => [name ?? '', phone ?? '', email ?? ''];
}
