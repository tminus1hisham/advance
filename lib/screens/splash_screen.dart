import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.currency_exchange,
              size: 80,
              color: Colors.white,
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.easeOutBack)
            .fadeIn(duration: 600.ms),
            const SizedBox(height: 24),
            Text(
              'Advance',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
            )
            .animate(delay: 300.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOutCubic)
            .shimmer(delay: 1000.ms, duration: 1500.ms, color: Colors.white54),
            const SizedBox(height: 8),
            Text(
              'Financial Growth',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            )
            .animate(delay: 400.ms)
            .fadeIn(duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
