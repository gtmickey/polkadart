import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:sr25519/sr25519.dart' hide KeyPair;
import 'package:ss58/ss58.dart';

void main() {
  final kp = KeyPair.sr25519.fromSeed(
      Uint8List.fromList('12345678901234567890123456789012'.codeUnits));
  print("Address = ${kp.address}");
  final privateKey = kp.getPrivateKey();
  print("privatekey = ${hex.encode(privateKey)}");

  final sc =
      SecretKey.from(privateKey, List<int>.filled(32, 0, growable: false));

  final address = Address(prefix: 42, pubkey: Uint8List.fromList(sc.public().encode()));
  print("Address = ${address.encode()}");
}
