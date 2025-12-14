import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _kAccess = 'accessToken';
  static const _kRefresh = 'refreshToken';
  static const _kAccountId = 'accountId';
  static const _kCompanyId = 'companyId';
  static const _kEmail = 'email';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int accountId,
    int? companyId,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccess, accessToken);
    await prefs.setString(_kRefresh, refreshToken);
    await prefs.setInt(_kAccountId, accountId);
    if (companyId != null) {
      await prefs.setInt(_kCompanyId, companyId);
    }
    if (email != null) {
      await prefs.setString(_kEmail, email);
    }
  }

  Future<TokenBundle?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString(_kAccess);
    final refresh = prefs.getString(_kRefresh);
    final accountId = prefs.getInt(_kAccountId);
    final companyId = prefs.getInt(_kCompanyId);
    final email = prefs.getString(_kEmail);
    if (access == null || refresh == null || accountId == null) return null;
    return TokenBundle(
      accessToken: access,
      refreshToken: refresh,
      accountId: accountId,
      companyId: companyId,
      email: email,
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccess);
    await prefs.remove(_kRefresh);
    await prefs.remove(_kAccountId);
    await prefs.remove(_kCompanyId);
    await prefs.remove(_kEmail);
  }
}

class TokenBundle {
  final String accessToken;
  final String refreshToken;
  final int accountId;
  final int? companyId;
  final String? email;

  TokenBundle({
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
    this.companyId,
    this.email,
  });
}
