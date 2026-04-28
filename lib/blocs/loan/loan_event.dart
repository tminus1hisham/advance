part of 'loan_bloc.dart';

abstract class LoanEvent extends Equatable {
  const LoanEvent();

  @override
  List<Object> get props => [];
}

class LoanAmountSelected extends LoanEvent {
  final double amount;

  const LoanAmountSelected({required this.amount});

  @override
  List<Object> get props => [amount];
}

class LoanSubmitted extends LoanEvent {}

class LoanPinEntered extends LoanEvent {
  final String pin;

  const LoanPinEntered({required this.pin});

  @override
  List<Object> get props => [pin];
}

class LoanReset extends LoanEvent {}
