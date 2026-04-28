import 'package:flutter/material.dart';

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final historyItems = [
      {'title': 'Loan Repayment', 'date': 'Today, 10:42 AM', 'amount': '- KES 5,000', 'status': 'Success'},
      {'title': 'Loan Disbursed', 'date': '12 Apr, 09:15 AM', 'amount': '+ KES 50,000', 'status': 'Success'},
      {'title': 'Loan Repayment', 'date': '01 Apr, 02:30 PM', 'amount': '- KES 10,000', 'status': 'Success'},
      {'title': 'Loan Request', 'date': '01 Apr, 08:00 AM', 'amount': 'KES 10,000', 'status': 'Failed'},
      {'title': 'Loan Disbursed', 'date': '15 Mar, 11:20 AM', 'amount': '+ KES 25,000', 'status': 'Success'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan History'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: historyItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = historyItems[index];
          final isCredit = item['amount']!.startsWith('+');
          final isFailed = item['status'] == 'Failed';

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            leading: CircleAvatar(
              backgroundColor: isFailed 
                  ? theme.colorScheme.errorContainer 
                  : theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                isFailed ? Icons.error_outline : (isCredit ? Icons.call_received : Icons.call_made),
                color: isFailed ? theme.colorScheme.error : theme.colorScheme.primary,
              ),
            ),
            title: Text(item['title']!),
            subtitle: Text(item['date']!),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['amount']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCredit ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    decoration: isFailed ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (isFailed)
                  Text(
                    'Failed',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
