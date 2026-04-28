import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/storage_service.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  final StorageService storageService;

  LoanBloc({required this.storageService}) : super(LoanInitial()) {
    on<LoanAmountSelected>(_onAmountSelected);
    on<LoanSubmitted>(_onSubmitted);
    on<LoanPinEntered>(_onPinEntered);
    on<LoanReset>(_onReset);
  }

  void _onAmountSelected(LoanAmountSelected event, Emitter<LoanState> emit) {
    final interest = event.amount * 0.05;
    final total = event.amount + interest;
    emit(LoanAmountChosen(
      amount: event.amount,
      interest: interest,
      total: total,
    ));
  }

  Future<void> _onSubmitted(LoanSubmitted event, Emitter<LoanState> emit) async {
    final currentState = state;
    if (currentState is LoanAmountChosen) {
      emit(LoanProcessing(amount: currentState.amount));
      await storageService.saveLastLoanAmount(currentState.amount);
    }
  }

  Future<void> _onPinEntered(LoanPinEntered event, Emitter<LoanState> emit) async {
    final currentState = state;
    double amount = 0;
    if (currentState is LoanProcessing) {
      amount = currentState.amount;
    }

    emit(LoanProcessing(amount: amount));

    // Simulate network processing
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success/failure (90% success rate for demo)
    if (event.pin.length == 4) {
      emit(LoanApproved(amount: amount));
    } else {
      emit(const LoanFailed(reason: 'Invalid PIN. Please try again.'));
    }
  }

  void _onReset(LoanReset event, Emitter<LoanState> emit) {
    emit(LoanInitial());
  }
}
