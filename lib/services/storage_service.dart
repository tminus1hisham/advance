import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  static late SharedPreferences _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // ── Auth / Session ──────────────────────────────────────────────
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserName = 'user_name';
  static const _keyUserPhone = 'user_phone';
  static const _keyUserEmail = 'user_email';
  static const _keyAuthToken = 'auth_token';

  Future<void> saveSession({
    required String name,
    required String phone,
    String email = '',
    String token = '',
  }) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserName, name);
    await _prefs.setString(_keyUserPhone, phone);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyAuthToken, token);
  }

  Future<void> clearSession() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserName);
    await _prefs.remove(_keyUserPhone);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyAuthToken);
    await _prefs.remove(_keyLastLoanAmount);
  }

  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String get userName => _prefs.getString(_keyUserName) ?? '';
  String get userPhone => _prefs.getString(_keyUserPhone) ?? '';
  String get userEmail => _prefs.getString(_keyUserEmail) ?? '';
  String get authToken => _prefs.getString(_keyAuthToken) ?? '';

  // ── Loan data ───────────────────────────────────────────────────
  static const _keyLastLoanAmount = 'last_loan_amount';

  Future<void> saveLastLoanAmount(double amount) async {
    await _prefs.setDouble(_keyLastLoanAmount, amount);
  }

  double get lastLoanAmount => _prefs.getDouble(_keyLastLoanAmount) ?? 0;

  // ── User profile helpers ────────────────────────────────────────
  Future<void> updateProfile({String? name, String? phone, String? email}) async {
    if (name != null) await _prefs.setString(_keyUserName, name);
    if (phone != null) await _prefs.setString(_keyUserPhone, phone);
    if (email != null) await _prefs.setString(_keyUserEmail, email);
  }
}
