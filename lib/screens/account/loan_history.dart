import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Transactions',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, duration: 400.ms),
                  const SizedBox(height: 8),
                  Text(
                    'Track your recent loan requests and repayments.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, duration: 400.ms),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = historyItems[index];
                  final isCredit = item['amount']!.startsWith('+');
                  final isFailed = item['status'] == 'Failed';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          '/account/history/details',
                          arguments: item,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isFailed 
                                    ? theme.colorScheme.errorContainer 
                                    : (isCredit ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5) : theme.colorScheme.surface),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                isFailed ? Icons.error_outline : (isCredit ? Icons.call_received : Icons.call_made),
                                color: isFailed ? theme.colorScheme.error : theme.colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['date']!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item['amount']!,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isCredit ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                                    decoration: isFailed ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isFailed 
                                        ? theme.colorScheme.errorContainer 
                                        : theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item['status']!,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: isFailed ? theme.colorScheme.error : theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate(delay: (200 + index * 100).ms).fadeIn(duration: 400.ms).slideX(begin: 0.1, duration: 400.ms);
                },
                childCount: historyItems.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom padding for navbar
        ],
      ),
    );
  }
}
