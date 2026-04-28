import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/loan/new_loan_request.dart';
import 'screens/loan/loan_review.dart';
import 'screens/loan/pin_confirmation.dart';
import 'screens/loan/loan_request_success.dart';
import 'screens/loan/loan_disbursed.dart';
import 'screens/loan/loan_request_failed.dart';
import 'screens/account/loan_history.dart';
import 'screens/account/repayment_screen.dart';
import 'screens/account/profile_screen.dart';
import 'screens/utilities/support_screen.dart';
import 'screens/utilities/notifications_screen.dart';
import 'blocs/auth/auth_bloc.dart';

void main() {
  runApp(const AdvanceApp());
}

class AdvanceApp extends StatelessWidget {
  const AdvanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Advance',
        theme: AdvanceTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/loan/new': (context) => const NewLoanRequestScreen(),
          '/loan/review': (context) => LoanReviewScreen(
            loanAmount: ModalRoute.of(context)?.settings.arguments as double? ?? 0.0,
          ),
          '/loan/pin_confirmation': (context) => const PinConfirmationScreen(),
          '/loan/success': (context) => const LoanRequestSuccessScreen(),
          '/loan/disbursed': (context) => const LoanDisbursedScreen(),
          '/loan/failed': (context) => const LoanRequestFailedScreen(),
          '/account/history': (context) => const LoanHistoryScreen(),
          '/account/repay': (context) => const RepaymentScreen(),
          '/account/profile': (context) => const ProfileScreen(),
          '/utilities/support': (context) => const SupportScreen(),
          '/utilities/notifications': (context) => const NotificationsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
