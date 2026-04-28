part of 'loan_bloc.dart';

abstract class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

class LoanInitial extends LoanState {}

class LoanAmountChosen extends LoanState {
  final double amount;
  final double interest;
  final double total;

  const LoanAmountChosen({
    required this.amount,
    required this.interest,
    required this.total,
  });

  @override
  List<Object> get props => [amount, interest, total];
}

class LoanProcessing extends LoanState {
  final double amount;

  const LoanProcessing({required this.amount});

  @override
  List<Object> get props => [amount];
}

class LoanApproved extends LoanState {
  final double amount;

  const LoanApproved({required this.amount});

  @override
  List<Object> get props => [amount];
}

class LoanDisbursed extends LoanState {
  final double amount;

  const LoanDisbursed({required this.amount});

  @override
  List<Object> get props => [amount];
}

class LoanFailed extends LoanState {
  final String reason;

  const LoanFailed({required this.reason});

  @override
  List<Object> get props => [reason];
}
