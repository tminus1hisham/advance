import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/loan/loan_bloc.dart';

class LoanReviewScreen extends StatelessWidget {
  const LoanReviewScreen({super.key});

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoanBloc, LoanState>(
      builder: (context, state) {
        double loanAmount = 0;
        double interest = 0;
        double totalRepayment = 0;

        if (state is LoanAmountChosen) {
          loanAmount = state.amount;
          interest = state.interest;
          totalRepayment = state.total;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Review Loan'),
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.onSurface,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Loan Amount',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'KES ${_formatCurrency(loanAmount.toInt())}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Loan Details',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow(context, 'Interest Rate', '5%'),
                const Divider(height: 32),
                _buildDetailRow(context, 'Interest Amount', 'KES ${_formatCurrency(interest.toInt())}'),
                const Divider(height: 32),
                _buildDetailRow(context, 'Duration', '30 Days'),
                const Divider(height: 32),
                _buildDetailRow(
                  context,
                  'Total Repayment',
                  'KES ${_formatCurrency(totalRepayment.toInt())}',
                  isTotal: true,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoanBloc>().add(LoanSubmitted());
                    Navigator.pushNamed(context, '/loan/pin_confirmation');
                  },
                  child: const Text('Confirm Loan Request'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, {bool isTotal = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isTotal ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
