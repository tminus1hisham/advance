import 'package:flutter/material.dart';

class LoanHistoryDetailsScreen extends StatelessWidget {
  final Map<String, String> loanDetails;

  const LoanHistoryDetailsScreen({super.key, required this.loanDetails});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Fallbacks if mapped data isn't perfect
    final title = loanDetails['title'] ?? 'Transaction Detail';
    final amount = loanDetails['amount'] ?? 'KES 0';
    final status = loanDetails['status'] ?? 'Completed';
    final date = loanDetails['date'] ?? 'Unknown Date';
    final isCredit = amount.startsWith('+') || amount.contains('Request');
    final isFailed = status == 'Failed';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: isFailed 
                        ? theme.colorScheme.errorContainer 
                        : theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      isFailed ? Icons.error_outline : (isCredit ? Icons.call_received : Icons.call_made),
                      size: 32,
                      color: isFailed ? theme.colorScheme.error : theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    amount,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isFailed ? theme.colorScheme.error : (isCredit ? theme.colorScheme.primary : theme.colorScheme.onSurface),
                      decoration: isFailed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (isFailed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Failed Transaction',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Details',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildDetailRow(context, 'Transaction ID', 'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'),
                  const Divider(height: 32),
                  _buildDetailRow(context, 'Date & Time', date),
                  const Divider(height: 32),
                  _buildDetailRow(context, 'Status', status),
                  const Divider(height: 32),
                  _buildDetailRow(context, 'Fee Applied', 'KES 0'),
                ],
              ),
            ),
            const SizedBox(height: 48),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/utilities/support');
              },
              child: const Text('Report an Issue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
