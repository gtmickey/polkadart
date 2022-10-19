part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 8-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU8.encode(69);
/// final decoded = CodecU8.decode("0x45");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU8 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u8(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u8();
  }
}
