import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/storage_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final StorageService storageService;

  UserBloc({required this.storageService}) : super(UserInitial()) {
    on<LoadUserProfile>(_onLoadProfile);
    on<UpdateUserProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(LoadUserProfile event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final name = storageService.userName;
    final phone = storageService.userPhone;
    final email = storageService.userEmail;

    // In a real app these would come from an API; using demo values for now
    emit(UserLoaded(
      name: name.isNotEmpty ? name : 'Jane Doe',
      phone: phone.isNotEmpty ? phone : '+254 712 345 678',
      email: email.isNotEmpty ? email : 'jane.doe@email.com',
      availableLimit: 150000,
      outstandingBalance: 52500,
    ));
  }

  Future<void> _onUpdateProfile(UpdateUserProfile event, Emitter<UserState> emit) async {
    await storageService.updateProfile(
      name: event.name,
      phone: event.phone,
      email: event.email,
    );

    // Reload after update
    add(LoadUserProfile());
  }
}
