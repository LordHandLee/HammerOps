import 'package:hammer_ops/services/api_client.dart';

class AuthApi {
  AuthApi(this.api);

  final ApiClient api;

  Future<AuthTokens> signup({
    required String email,
    required String password,
    String? companyName,
  }) async {
    final res = await api.postJson('/auth/signup', body: {
      'email': email,
      'password': password,
      if (companyName != null) 'companyName': companyName,
    });
    return AuthTokens.fromJson(res);
  }

  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    final res = await api.postJson('/auth/login', body: {
      'email': email,
      'password': password,
    });
    return AuthTokens.fromJson(res);
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    final res =
        await api.postJson('/auth/refresh', body: {'refreshToken': refreshToken});
    return AuthTokens.fromJson(res);
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final int accountId;
  final int? companyId;
  final int? refreshSessionId;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
    this.companyId,
    this.refreshSessionId,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accountId: json['accountId'] as int,
      companyId: json['companyId'] as int?,
      refreshSessionId: json['refreshSessionId'] as int?,
    );
  }
}
