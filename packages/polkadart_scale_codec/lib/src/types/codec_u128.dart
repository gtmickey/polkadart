part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 128-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU128.encode(16777215);
/// final decoded = CodecU128.decode("0xffffff00000000000000000000000000");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU128 implements ScaleCodecType {
  @override
  String encodeToHex(value) {
    if (value is! BigInt) {
      throw UnexpectedTypeException(
        expectedType: 'BigInt',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexEncoder();
    sink.u128(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u128();
  }
}
