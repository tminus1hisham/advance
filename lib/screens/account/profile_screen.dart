import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          final name = userState is UserLoaded ? userState.name : 'User';
          final phone = userState is UserLoaded ? userState.phone : '';
          final initials = userState is UserLoaded ? userState.initials : '?';

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(initials, style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer)),
                  ),
                  const SizedBox(height: 16),
                  Text(name, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(phone, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 48),
                  _buildItem(context, Icons.person_outline, 'Personal Details'),
                  const Divider(height: 1),
                  _buildItem(context, Icons.security, 'Security'),
                  const Divider(height: 1),
                  _buildItem(context, Icons.description_outlined, 'Terms and Conditions'),
                  const Divider(height: 1),
                  _buildItem(context, Icons.help_outline, 'Help Center'),
                  const SizedBox(height: 48),
                  OutlinedButton(
                    onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
                    style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error, side: BorderSide(color: theme.colorScheme.error)),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
