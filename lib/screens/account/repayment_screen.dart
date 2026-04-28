import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user/user_bloc.dart';

class RepaymentScreen extends StatefulWidget {
  const RepaymentScreen({super.key});

  @override
  State<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends State<RepaymentScreen> {
  double _repaymentAmount = 5000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final outstanding = userState is UserLoaded ? userState.outstandingBalance : 0.0;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Make a Repayment'),
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.onSurface,
            elevation: 0,
          ),
          body: Padding(
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
                      Text('Outstanding Balance', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      Text('KES ${outstanding.toInt()}', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.error)),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Text('How much do you want to repay?', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                TextFormField(
                  initialValue: _repaymentAmount.toInt().toString(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                  decoration: const InputDecoration(prefixText: 'KES ', border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, filled: false),
                  onChanged: (value) {
                    final amount = double.tryParse(value);
                    if (amount != null) setState(() => _repaymentAmount = amount);
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/loan/pin_confirmation'),
                  child: const Text('Pay via M-PESA'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
