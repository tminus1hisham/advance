import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../main.dart' show themeController;

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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // ── Profile Header ──────────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.primaryContainer,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.surface,
                            ),
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: theme.colorScheme.primaryContainer,
                              child: Text(
                                initials,
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ).animate().scale(duration: 450.ms, curve: Curves.easeOutBack),
                        const SizedBox(height: 16),
                        Text(
                          name,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2),
                        const SizedBox(height: 4),
                        Text(
                          phone,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ).animate(delay: 180.ms).fadeIn().slideY(begin: 0.2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Account Settings Card ───────────────────────────────
                  _SettingsCard(
                    children: [
                      _buildItem(context, Icons.person_outline_rounded, 'Personal Details'),
                      _divider(theme),
                      _buildItem(context, Icons.security_rounded, 'Security'),
                    ],
                  ).animate(delay: 260.ms).fadeIn().slideX(begin: 0.1),
                  const SizedBox(height: 16),

                  // ── Appearance Card ─────────────────────────────────────
                  _AppearanceCard().animate(delay: 320.ms).fadeIn().slideX(begin: 0.1),
                  const SizedBox(height: 16),

                  // ── Legal Card ──────────────────────────────────────────
                  _SettingsCard(
                    children: [
                      _buildItem(context, Icons.description_outlined, 'Terms and Conditions'),
                      _divider(theme),
                      _buildItem(context, Icons.help_outline_rounded, 'Help Center'),
                    ],
                  ).animate(delay: 380.ms).fadeIn().slideX(begin: 0.1),
                  const SizedBox(height: 40),

                  // ── Sign Out ────────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(
                          color: theme.colorScheme.error.withValues(alpha: 0.4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ).animate(delay: 440.ms).fadeIn().slideY(begin: 0.2),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _divider(ThemeData theme) => Divider(
        height: 1,
        indent: 56,
        endIndent: 16,
        color: theme.colorScheme.outline.withValues(alpha: 0.12),
      );

  Widget _buildItem(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.outline,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable settings card shell ───────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(children: children),
      ),
    );
  }
}

// ── Appearance / theme toggle card ────────────────────────────────────────────
class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.contrast_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                'Appearance',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            // Three-way toggle: Light | System | Dark
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeController,
              builder: (context, mode, _) {
                return _ThemeModeSelector(current: mode);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Segmented three-way toggle ─────────────────────────────────────────────────
class _ThemeModeSelector extends StatelessWidget {
  final ThemeMode current;
  const _ThemeModeSelector({required this.current});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 32,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Seg(
            icon: Icons.light_mode_rounded,
            selected: current == ThemeMode.light,
            onTap: themeController.setLight,
          ),
          _Seg(
            icon: Icons.phone_android_rounded,
            selected: current == ThemeMode.system,
            onTap: themeController.setSystem,
          ),
          _Seg(
            icon: Icons.dark_mode_rounded,
            selected: current == ThemeMode.dark,
            onTap: themeController.setDark,
          ),
        ],
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _Seg({required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: 34,
        height: 26,
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: 15,
          color: selected ? Colors.white : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
