import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../blocs/user/user_bloc.dart';
import '../widgets/floating_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUserProfile());
  }

  String _formatCurrency(double amount) {
    return amount.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final userName = userState is UserLoaded ? userState.name : 'User';
        final availableLimit = userState is UserLoaded ? userState.availableLimit : 0.0;
        final firstName = userName.split(' ').first;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            extendBody: true,
            backgroundColor: theme.colorScheme.surface,
            body: CustomScrollView(
              slivers: [
                // ── Custom SliverAppBar ──────────────────────────────────
                SliverAppBar(
                  pinned: true,
                  backgroundColor: theme.colorScheme.surface,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  expandedHeight: 0,
                  titleSpacing: 20,
                  title: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primaryContainer,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Advance',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.notifications_outlined,
                          color: theme.colorScheme.onSurface),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/utilities/notifications'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/account/profile'),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Text(
                            firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Body ─────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),

                        // Greeting
                        Text(
                          '${_greeting()},',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
                        const SizedBox(height: 2),
                        Text(
                          firstName,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ).animate(delay: 80.ms).fadeIn(duration: 400.ms).slideX(begin: -0.1),
                        const SizedBox(height: 24),

                        // ── Balance Hero Card ─────────────────────────────
                        _BalanceHeroCard(
                          availableLimit: availableLimit,
                          formatCurrency: _formatCurrency,
                          isDark: isDark,
                        ).animate(delay: 160.ms)
                            .fadeIn(duration: 500.ms)
                            .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack),

                        const SizedBox(height: 32),

                        // ── Quick Actions ─────────────────────────────────
                        Text(
                          'Quick Actions',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ).animate(delay: 220.ms).fadeIn(),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _QuickActionChip(
                              icon: Icons.history_rounded,
                              label: 'History',
                              color: const Color(0xFF00658C),
                              onTap: () => Navigator.pushNamed(context, '/account/history'),
                            ).animate(delay: 280.ms).fadeIn().slideY(begin: 0.3),
                            const SizedBox(width: 12),
                            _QuickActionChip(
                              icon: Icons.payments_rounded,
                              label: 'Repay',
                              color: const Color(0xFF2E7D32),
                              onTap: () => Navigator.pushNamed(context, '/account/repay'),
                            ).animate(delay: 340.ms).fadeIn().slideY(begin: 0.3),
                            const SizedBox(width: 12),
                            _QuickActionChip(
                              icon: Icons.support_agent_rounded,
                              label: 'Support',
                              color: const Color(0xFF6A1B9A),
                              onTap: () => Navigator.pushNamed(context, '/utilities/support'),
                            ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.3),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // ── Recent Activity ───────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Activity',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/account/history'),
                              child: Text(
                                'See all',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ).animate(delay: 460.ms).fadeIn(),
                        const SizedBox(height: 14),

                        ..._recentActivity(context, theme),

                        const SizedBox(height: 110), // space for floating navbar
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Floating Pill Navbar ──────────────────────────────────────
            bottomNavigationBar: _FloatingNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == _currentIndex) return;
                switch (index) {
                  case 1:
                    Navigator.pushNamed(context, '/account/history');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/account/profile');
                    break;
                }
              },
            ),
          ),
        );
      },
    );
  }

  List<Widget> _recentActivity(BuildContext context, ThemeData theme) {
    final items = [
      _ActivityData(
        title: 'Loan Repayment',
        subtitle: 'Yesterday, 10:42 AM',
        amount: '- KES 5,000',
        isCredit: false,
      ),
      _ActivityData(
        title: 'Loan Disbursed',
        subtitle: '12 Apr, 09:15 AM',
        amount: '+ KES 50,000',
        isCredit: true,
      ),
      _ActivityData(
        title: 'Loan Repayment',
        subtitle: '01 Apr, 02:30 PM',
        amount: '- KES 10,000',
        isCredit: false,
      ),
    ];

    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _ActivityCard(item: item, theme: theme),
      ).animate(delay: (500 + i * 80).ms).fadeIn(duration: 400.ms).slideX(begin: 0.08);
    }).toList();
  }
}

// ── Balance Hero Card ──────────────────────────────────────────────────────────
class _BalanceHeroCard extends StatelessWidget {
  final double availableLimit;
  final String Function(double) formatCurrency;
  final bool isDark;

  const _BalanceHeroCard({
    required this.availableLimit,
    required this.formatCurrency,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFD7782C), Color(0xFFE8953A), Color(0xFFF0A84D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD7782C).withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative blobs
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Color(0xFF4ADE80), size: 8),
                          SizedBox(width: 6),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Available Limit',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'KES ${formatCurrency(availableLimit)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/loan/new'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_rounded,
                            color: Color(0xFFD7782C), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Request Loan',
                          style: TextStyle(
                            color: Color(0xFFD7782C),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Action Chip ──────────────────────────────────────────────────────────
class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Activity Data ──────────────────────────────────────────────────────────────
class _ActivityData {
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;

  const _ActivityData({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
  });
}

// ── Activity Card ──────────────────────────────────────────────────────────────
class _ActivityCard extends StatelessWidget {
  final _ActivityData item;
  final ThemeData theme;

  const _ActivityCard({required this.item, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.isCredit
                  ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
                  : theme.colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isCredit ? Icons.call_received_rounded : Icons.call_made_rounded,
              color: item.isCredit
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item.amount,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: item.isCredit
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Floating Nav Bar ───────────────────────────────────────────────────────────
class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              height: 66,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.18),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(index: 0, currentIndex: currentIndex, icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home', onTap: onTap),
                  _NavItem(index: 1, currentIndex: currentIndex, icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet_rounded, label: 'Loans', onTap: onTap),
                  _NavItem(index: 2, currentIndex: currentIndex, icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile', onTap: onTap),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final void Function(int) onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 18 : 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              size: 22,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.3, duration: 200.ms),
            ],
          ],
        ),
      ),
    );
  }
}
