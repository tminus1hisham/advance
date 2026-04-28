import 'package:flutter/material.dart';

class NewLoanRequestScreen extends StatefulWidget {
  const NewLoanRequestScreen({super.key});

  @override
  State<NewLoanRequestScreen> createState() => _NewLoanRequestScreenState();
}

class _NewLoanRequestScreenState extends State<NewLoanRequestScreen> {
  double _loanAmount = 10000;
  final double _maxLimit = 150000;
  final double _minLimit = 1000;

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
            ),
            const SizedBox(height: 8),
            Text(
              'Your available limit is KES 150,000',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: Text(
                'KES ${_loanAmount.toInt().toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('KES ${_minLimit.toInt()}', style: theme.textTheme.labelMedium),
                Text('KES ${_maxLimit.toInt()}', style: theme.textTheme.labelMedium),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loan/review', arguments: _loanAmount);
              },
              child: const Text('Continue'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
