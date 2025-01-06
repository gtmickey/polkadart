import 'dart:async';
import 'dart:convert';

import 'package:polkadart/provider.dart';


final class GTHTTPProvider extends Provider {
  GTHTTPProvider(this.uri) : super();

  final Uri uri;

  int _sequence = 0;

  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    final data = await GTWeb3DartRPCClient.instance.post(
      uri: uri,
      body: {
        'id': ++_sequence,
        'jsonrpc': '2.0',
        'method': method,
        'params': params,
      },
    ).then((value) {
      if(value['data'] is String) {
        return jsonDecode(value['data']) as Map;
      } else {
        return (value['data'] as Map).cast();
      }
    });
    return RpcResponse(
      id: int.tryParse(data['id'].toString()) ?? -1,
      result: data['result'],
      error: data['error'],
    );
  }

  @override
  Future<SubscriptionResponse> subscribe(
    String method,
    List params, {
    FutureOr<void> Function(String subscription)? onCancel,
  }) {
    throw Exception('HttpProvider does not support subscriptions');
  }

  @override
  Future connect() {
    return Future.value();
  }

  @override
  Future disconnect() {
    return Future.value();
  }

  @override
  bool isConnected() {
    return true;
  }

  static bool isEnabled() {
    return GTWeb3DartRPCClient._instance != null;
  }
}

abstract class GTWeb3DartRPCClient {
  const GTWeb3DartRPCClient();

  Future<Map<String, dynamic>> post({
    required Uri uri,
    required dynamic body,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  });

  static void init(GTWeb3DartRPCClient client) {
    _instance = client;
  }

  static GTWeb3DartRPCClient? _instance;

  static GTWeb3DartRPCClient get instance {
    assert(_instance != null, 'GTWeb3DartRPCClient is not initialized');
    return _instance!;
  }
}
