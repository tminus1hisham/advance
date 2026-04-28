import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/loan/loan_bloc.dart';

class PinConfirmationScreen extends StatefulWidget {
  const PinConfirmationScreen({super.key});

  @override
  State<PinConfirmationScreen> createState() => _PinConfirmationScreenState();
}

class _PinConfirmationScreenState extends State<PinConfirmationScreen> {
  final _pinController = TextEditingController();

  void _confirmPin() {
    if (_pinController.text.length == 4) {
      context.read<LoanBloc>().add(LoanPinEntered(pin: _pinController.text));
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<LoanBloc, LoanState>(
      listener: (context, state) {
        if (state is LoanApproved) {
          Navigator.pushReplacementNamed(context, '/loan/success');
        } else if (state is LoanFailed) {
          Navigator.pushReplacementNamed(context, '/loan/failed');
        }
      },
      child: BlocBuilder<LoanBloc, LoanState>(
        builder: (context, state) {
          final isProcessing = state is LoanProcessing;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Confirm PIN'),
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  Icon(
                    Icons.dialpad,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Enter Your PIN',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your 4-digit PIN to authorize this transaction.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    enabled: !isProcessing,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      letterSpacing: 24,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.length == 4) {
                        _confirmPin();
                      }
                    },
                  ),
                  const SizedBox(height: 48),
                  if (isProcessing)
                    const Center(child: CircularProgressIndicator())
                  else
                    ElevatedButton(
                      onPressed: _pinController.text.length == 4 ? _confirmPin : null,
                      child: const Text('Confirm'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
