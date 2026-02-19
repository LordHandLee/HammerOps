import 'package:hammer_ops/services/api_client.dart';

class AuthApi {
  AuthApi(this.api);

  final ApiClient api;

  Future<SignupResult> signup({
    required String email,
    required String password,
    String? companyName,
    String? inviteCode,
  }) async {
    final res = await api.postJson('/auth/signup', body: {
      'email': email,
      'password': password,
      if (companyName != null) 'companyName': companyName,
      if (inviteCode != null) 'inviteCode': inviteCode,
    });
    return SignupResult.fromJson(res);
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

  Future<InviteResult> invite({
    required String email,
    required String accessToken,
  }) async {
    final res = await api.postJson(
      '/auth/invite',
      bearer: accessToken,
      body: {'email': email},
    );
    return InviteResult.fromJson(res);
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    final res =
        await api.postJson('/auth/refresh', body: {'refreshToken': refreshToken});
    return AuthTokens.fromJson(res);
  }
}

class SignupResult {
  final String message;

  SignupResult({required this.message});

  factory SignupResult.fromJson(Map<String, dynamic> json) {
    return SignupResult(message: json['message'] as String? ?? 'Account created.');
  }
}

class InviteResult {
  final int inviteId;
  final String message;

  InviteResult({required this.inviteId, required this.message});

  factory InviteResult.fromJson(Map<String, dynamic> json) {
    return InviteResult(
      inviteId: json['inviteId'] as int? ?? 0,
      message: json['message'] as String? ?? 'Invite sent.',
    );
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
