import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoanDisbursedScreen extends StatelessWidget {
  const LoanDisbursedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 96,
                  color: theme.colorScheme.tertiary,
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack).fadeIn(duration: 600.ms),
              const SizedBox(height: 48),
              Text(
                'Funds Disbursed',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, duration: 500.ms),
              const SizedBox(height: 16),
              Text(
                'Your loan has been successfully disbursed to your account. You can now access your funds.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, duration: 500.ms),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                child: const Text('View Account Balance'),
              ).animate(delay: 500.ms).fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
