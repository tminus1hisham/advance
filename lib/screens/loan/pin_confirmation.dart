import 'package:flutter/material.dart';

class PinConfirmationScreen extends StatefulWidget {
  const PinConfirmationScreen({super.key});

  @override
  State<PinConfirmationScreen> createState() => _PinConfirmationScreenState();
}

class _PinConfirmationScreenState extends State<PinConfirmationScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  void _confirmPin() async {
    if (_pinController.text.length == 4) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;
      // Navigate to success for demo purposes
      Navigator.pushReplacementNamed(context, '/loan/success');
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
            if (_isLoading)
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
  }
}
