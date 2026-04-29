import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:advance/services/storage_service.dart';

class ApiService {
  static const String baseUrl = 'http://137.184.142.102:8085';

  static Future<Map<String, String>> _getHeaders() async {
    final storage = await StorageService.getInstance();
    final token = storage.authToken;
    return {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> _post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  static Future<dynamic> _get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  static Future<dynamic> _put(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    final response = await http.put(url, headers: headers, body: body != null ? jsonEncode(body) : null);
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  // ── Authentication ──────────────────────────────────────────────

  static Future<dynamic> verifyOtp(String phone, String otp) {
    return _post('/api/v1/auth/verify-otp', {'phoneNumber': phone, 'otp': otp});
  }

  static Future<dynamic> sendOtp(String phone) {
    return _post('/api/v1/auth/send-otp', {'phoneNumber': phone});
  }

  static Future<dynamic> refreshToken(String refreshToken) {
    return _post('/api/v1/auth/refresh', {'refreshToken': refreshToken});
  }

  static Future<dynamic> logout() {
    return _post('/api/v1/auth/logout', {});
  }

  static Future<dynamic> registerEmployerAdmin(Map<String, dynamic> data) {
    return _post('/api/v1/auth/employer-admin/register', data);
  }

  static Future<dynamic> resetEmployeePin(String phone, String otp, String newPin) {
    return _post('/api/v1/auth/employee/reset-pin', {'phoneNumber': phone, 'otp': otp, 'newPin': newPin});
  }

  static Future<dynamic> registerEmployee(Map<String, dynamic> data) {
    return _post('/api/v1/auth/employee/register', data);
  }

  static Future<dynamic> loginEmployee(String phone, String pin) {
    return _post('/api/v1/auth/employee/login', {'phoneNumber': phone, 'pin': pin});
  }

  static Future<dynamic> forgotEmployeePin(String phone) {
    return _post('/api/v1/auth/employee/forgot-pin', {'phoneNumber': phone});
  }

  static Future<dynamic> registerCreditor(Map<String, dynamic> data) {
    return _post('/api/v1/auth/creditor/register', data);
  }

  static Future<dynamic> changePassword(String oldPassword, String newPassword) {
    return _post('/api/v1/auth/change-password', {'oldPassword': oldPassword, 'newPassword': newPassword});
  }

  static Future<dynamic> loginAdmin(String email, String password) {
    return _post('/api/v1/auth/admin/login', {'email': email, 'password': password});
  }

  // ── Employee Management ─────────────────────────────────────────

  static Future<dynamic> getEmployee(String employeeId) {
    return _get('/api/v1/employees/$employeeId');
  }

  static Future<dynamic> getEmployeeDashboard() {
    return _get('/api/v1/employees/me/dashboard');
  }

  static Future<dynamic> getEmployerEmployees(String employerId) {
    return _get('/api/v1/employees/employer/$employerId');
  }

  static Future<dynamic> deactivateEmployee(String employeeId) {
    return _put('/api/v1/employees/$employeeId/deactivate');
  }

  // ── Loan Management ─────────────────────────────────────────────

  static Future<dynamic> getEmployerPendingLoans(String employerId) {
    return _get('/api/v1/loans/employer/$employerId/pending');
  }

  static Future<dynamic> getEmployeeLoanHistory(String phoneNumber) {
    return _get('/api/v1/loans/employee/$phoneNumber');
  }

  static Future<dynamic> requestLoan(Map<String, dynamic> data) {
    return _post('/api/v1/loans/request', data);
  }

  static Future<dynamic> rejectLoan(String loanId) {
    return _put('/api/v1/loans/$loanId/reject');
  }

  static Future<dynamic> approveLoan(String loanId) {
    return _put('/api/v1/loans/$loanId/approve');
  }

  // ── Settlement Management ───────────────────────────────────────

  static Future<dynamic> getEmployerSettlements(String employerId) {
    return _get('/api/v1/settlements/employer/$employerId');
  }

  static Future<dynamic> recordSettlement(Map<String, dynamic> data) {
    return _post('/api/v1/settlements', data);
  }
}
