part of primitives;

class I32Codec with Codec<int> {
  const I32Codec._();

  static const I32Codec codec = I32Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -2147483648 || value > 2147483647) {
      throw OutOfBoundsException();
    }
    U32Codec.codec.encodeTo(value.toUnsigned(32), output);
  }

  @override
  int decode(Input input) {
    return U32Codec.codec.decode(input).toSigned(32);
  }

  @override
  int sizeHint(int value) {
    return 4;
  }
}

class I32SequenceCodec with Codec<List<int>> {
  const I32SequenceCodec._();

  static const I32SequenceCodec codec = I32SequenceCodec._();

  @override
  Int32Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Int32Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = I32Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      I32Codec.codec.encodeTo(value, output);
    }
  }

  @override
  int sizeHint(List<int> list) {
    return CompactCodec.codec.sizeHint(list.length) + list.length * 4;
  }
}

class I32ArrayCodec with Codec<Int32List> {
  final int length;
  const I32ArrayCodec(this.length);

  @override
  Int32List decode(Input input) {
    final list = Int32List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I32Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Int32List list, Output output) {
    if (list.length != length) {
      throw Exception(
          'I32ArrayCodec: invalid length, expect $length found ${list.length}');
    }
    for (var i = 0; i < length; i++) {
      I32Codec.codec.encodeTo(list[i], output);
    }
  }

  @override
  int sizeHint(Int32List list) {
    return length * 4;
  }
}