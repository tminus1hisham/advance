import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../blocs/loan/loan_bloc.dart';
import '../../blocs/user/user_bloc.dart';

class NewLoanRequestScreen extends StatefulWidget {
  const NewLoanRequestScreen({super.key});

  @override
  State<NewLoanRequestScreen> createState() => _NewLoanRequestScreenState();
}

class _NewLoanRequestScreenState extends State<NewLoanRequestScreen> {
  double _loanAmount = 10000;
  late double _maxLimit;
  final double _minLimit = 1000;

  @override
  void initState() {
    super.initState();
    final userState = context.read<UserBloc>().state;
    _maxLimit = userState is UserLoaded ? userState.availableLimit : 150000;
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Loan'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How much do you need?',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              'Your available limit is KES ${_formatCurrency(_maxLimit.toInt())}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, duration: 400.ms),
            const SizedBox(height: 48),
            Center(
              child: Text(
                'KES ${_formatCurrency(_loanAmount.toInt())}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ).animate(target: _loanAmount).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 100.ms).then().scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1), duration: 100.ms),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8), duration: 400.ms),
            const SizedBox(height: 32),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: theme.colorScheme.primary,
                inactiveTrackColor: theme.colorScheme.primaryContainer,
                thumbColor: theme.colorScheme.primary,
                trackHeight: 8.0,
              ),
              child: Slider(
                value: _loanAmount,
                min: _minLimit,
                max: _maxLimit,
                divisions: ((_maxLimit - _minLimit) / 1000).toInt(),
                onChanged: (value) {
                  setState(() {
                    _loanAmount = value;
                  });
                },
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, duration: 500.ms),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('KES ${_minLimit.toInt()}', style: theme.textTheme.labelMedium),
                Text('KES ${_formatCurrency(_maxLimit.toInt())}', style: theme.textTheme.labelMedium),
              ],
            ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Dispatch to LoanBloc then navigate
                context.read<LoanBloc>().add(LoanAmountSelected(amount: _loanAmount));
                Navigator.pushNamed(context, '/loan/review');
              },
              child: const Text('Continue'),
            ).animate(delay: 500.ms).fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
