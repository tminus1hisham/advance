import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final notifications = [
      {'title': 'Loan Approved', 'message': 'Your recent loan request for KES 50,000 has been approved.', 'time': '2 hours ago', 'isUnread': true},
      {'title': 'Repayment Reminder', 'message': 'Your loan repayment of KES 10,500 is due in 3 days.', 'time': '1 day ago', 'isUnread': true},
      {'title': 'Welcome to Advance', 'message': 'Thank you for signing up. Your account is now fully active.', 'time': '1 week ago', 'isUnread': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isUnread = notification['isUnread'] as bool;

          return Container(
            color: isUnread ? theme.colorScheme.primaryContainer.withValues(alpha: 0.1) : null,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.notifications_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['message'] as String,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['time'] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: isUnread
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
