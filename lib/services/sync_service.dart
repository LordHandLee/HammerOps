import 'package:hammer_ops/services/api_client.dart';
import 'package:hammer_ops/services/token_storage.dart';

class SyncService {
  SyncService(this.api, this.tokens);

  final ApiClient api;
  final TokenStorage tokens;

  /// Push local changes to server and return conflicts (if any).
  Future<Map<String, dynamic>> push(List<Map<String, dynamic>> changes) async {
    final bundle = await tokens.load();
    if (bundle == null) {
      throw Exception('Not authenticated');
    }
    return api.postJson(
      '/sync/push',
      bearer: bundle.accessToken,
      body: {'changes': changes},
    );
  }

  /// Pull changes newer than [sinceVersion].
  Future<Map<String, dynamic>> pull(int sinceVersion) async {
    final bundle = await tokens.load();
    if (bundle == null) {
      throw Exception('Not authenticated');
    }
    return api.getJson(
      '/sync/pull',
      bearer: bundle.accessToken,
      query: {'since': '$sinceVersion'},
    );
  }
}
