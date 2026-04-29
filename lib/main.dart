import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/theme.dart';
import 'theme/theme_controller.dart';
import 'services/storage_service.dart';
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
import 'screens/account/loan_history_details.dart';
import 'screens/utilities/support_screen.dart';
import 'screens/utilities/notifications_screen.dart';
import 'screens/states/offline_state.dart';
import 'screens/states/general_error_state.dart';
import 'screens/states/account_locked.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/loan/loan_bloc.dart';
import 'blocs/user/user_bloc.dart';

final themeController = ThemeController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = await StorageService.getInstance();
  runApp(AdvanceApp(storageService: storageService));
}

class AdvanceApp extends StatelessWidget {
  final StorageService storageService;

  const AdvanceApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(storageService: storageService)),
        BlocProvider(create: (_) => LoanBloc(storageService: storageService)),
        BlocProvider(create: (_) => UserBloc(storageService: storageService)),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeController,
        builder: (context, mode, _) {
          return MaterialApp(
            title: 'Advance',
            theme: AdvanceTheme.lightTheme,
            darkTheme: AdvanceTheme.darkTheme,
            themeMode: mode,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/dashboard': (context) => const DashboardScreen(),
              '/loan/new': (context) => const NewLoanRequestScreen(),
              '/loan/review': (context) => const LoanReviewScreen(),
              '/loan/pin_confirmation': (context) => const PinConfirmationScreen(),
              '/loan/success': (context) => const LoanRequestSuccessScreen(),
              '/loan/disbursed': (context) => const LoanDisbursedScreen(),
              '/loan/failed': (context) => const LoanRequestFailedScreen(),
              '/account/history': (context) => const LoanHistoryScreen(),
              '/account/history/details': (context) => LoanHistoryDetailsScreen(
                loanDetails: ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {},
              ),
              '/account/repay': (context) => const RepaymentScreen(),
              '/account/profile': (context) => const ProfileScreen(),
              '/utilities/support': (context) => const SupportScreen(),
              '/utilities/notifications': (context) => const NotificationsScreen(),
              '/states/offline': (context) => const OfflineStateScreen(),
              '/states/error': (context) => const GeneralErrorStateScreen(),
              '/states/locked': (context) => const AccountLockedScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
