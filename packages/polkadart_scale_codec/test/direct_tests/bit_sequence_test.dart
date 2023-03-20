import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  test('BitSequence(U8, LSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U8, BitOrder.LSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00],
      '1': [0x04, 0x01],
      '00': [0x08, 0x00],
      '10': [0x08, 0x01],
      '01': [0x08, 0x02],
      '11': [0x08, 0x03],
      '101': [0x0c, 0x05],
      '0011': [0x10, 0x0c],
      '0111': [0x10, 0x0e],
      '1111': [0x10, 0x0f],
      '11111': [0x14, 0x1f],
      '111110': [0x18, 0x1f],
      '0101011': [0x1c, 0x6a],
      '01010110': [0x20, 0x6a],
      '110101101': [0x24, 0x6b, 0x01],
      '111110001101': [0x30, 0x1f, 0x0b],
      '101011001010110': [0x3c, 0x35, 0x35],
      '0101011001010110': [0x40, 0x6a, 0x6a],
      '01010110010101100': [0x44, 0x6a, 0x6a, 0x00],
      '000000000000000': [0x3c, 0x00, 0x00],
      '1111111111111111': [0x40, 0xff, 0xff],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7c, 0xff, 0xff, 0xff, 0x7f],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [0x84, 0xff, 0xff, 0xff, 0xff, 0x01],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xfc,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff,
        0xff
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U16, LSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U16, BitOrder.LSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00],
      '1': [0x04, 0x01, 0x00],
      '00': [0x08, 0x00, 0x00],
      '10': [0x08, 0x01, 0x00],
      '01': [0x08, 0x02, 0x00],
      '11': [0x08, 0x03, 0x00],
      '101': [0x0C, 0x05, 0x00],
      '0011': [0x10, 0x0C, 0x00],
      '0111': [0x10, 0x0E, 0x00],
      '1111': [0x10, 0x0F, 0x00],
      '11111': [0x14, 0x1F, 0x00],
      '111110': [0x18, 0x1F, 0x00],
      '0101011': [0x1C, 0x6A, 0x00],
      '01010110': [0x20, 0x6A, 0x00],
      '110101101': [0x24, 0x6B, 0x01],
      '111110001101': [0x30, 0x1F, 0x0B],
      '101011001010110': [0x3C, 0x35, 0x35],
      '0101011001010110': [0x40, 0x6A, 0x6A],
      '01010110010101100': [0x44, 0x6A, 0x6A, 0x00, 0x00],
      '000000000000000': [0x3C, 0x00, 0x00],
      '1111111111111111': [0x40, 0xFF, 0xFF],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7C, 0xFF, 0xFF, 0xFF, 0x7F],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [
        0x84,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0x01,
        0x00
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U32, LSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U32, BitOrder.LSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00, 0x00, 0x00],
      '1': [0x04, 0x01, 0x00, 0x00, 0x00],
      '00': [0x08, 0x00, 0x00, 0x00, 0x00],
      '10': [0x08, 0x01, 0x00, 0x00, 0x00],
      '01': [0x08, 0x02, 0x00, 0x00, 0x00],
      '11': [0x08, 0x03, 0x00, 0x00, 0x00],
      '101': [0x0C, 0x05, 0x00, 0x00, 0x00],
      '0011': [0x10, 0x0C, 0x00, 0x00, 0x00],
      '0111': [0x10, 0x0E, 0x00, 0x00, 0x00],
      '1111': [0x10, 0x0F, 0x00, 0x00, 0x00],
      '11111': [0x14, 0x1F, 0x00, 0x00, 0x00],
      '111110': [0x18, 0x1F, 0x00, 0x00, 0x00],
      '0101011': [0x1C, 0x6A, 0x00, 0x00, 0x00],
      '01010110': [0x20, 0x6A, 0x00, 0x00, 0x00],
      '110101101': [0x24, 0x6B, 0x01, 0x00, 0x00],
      '111110001101': [0x30, 0x1F, 0x0B, 0x00, 0x00],
      '101011001010110': [0x3C, 0x35, 0x35, 0x00, 0x00],
      '0101011001010110': [0x40, 0x6A, 0x6A, 0x00, 0x00],
      '01010110010101100': [0x44, 0x6A, 0x6A, 0x00, 0x00],
      '000000000000000': [0x3C, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111': [0x40, 0xFF, 0xFF, 0x00, 0x00],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7C, 0xFF, 0xFF, 0xFF, 0x7F],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [
        0x84,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0x01,
        0x00,
        0x00,
        0x00
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U64, LSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U64, BitOrder.LSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '1': [0x04, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '00': [0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '10': [0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '01': [0x08, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '11': [0x08, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '101': [0x0C, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '0011': [0x10, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '0111': [0x10, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '1111': [0x10, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '11111': [0x14, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '111110': [0x18, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '0101011': [0x1C, 0x6A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '01010110': [0x20, 0x6A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '110101101': [0x24, 0x6B, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '111110001101': [0x30, 0x1F, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '101011001010110': [0x3C, 0x35, 0x35, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '0101011001010110': [
        0x40,
        0x6A,
        0x6A,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '01010110010101100': [
        0x44,
        0x6A,
        0x6A,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '000000000000000': [0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111': [
        0x40,
        0xFF,
        0xFF,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '00000000000000000': [
        0x44,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111': [
        0x7C,
        0xFF,
        0xFF,
        0xFF,
        0x7F,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '00000000000000000000000000000000': [
        0x80,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '111111111111111111111111111111111': [
        0x84,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0x01,
        0x00,
        0x00,
        0x00
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U8, MSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U8, BitOrder.MSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00],
      '1': [0x04, 0x80],
      '00': [0x08, 0x00],
      '10': [0x08, 0x80],
      '01': [0x08, 0x40],
      '11': [0x08, 0xC0],
      '101': [0x0C, 0xA0],
      '0011': [0x10, 0x30],
      '0111': [0x10, 0x70],
      '1111': [0x10, 0xF0],
      '11111': [0x14, 0xF8],
      '111110': [0x18, 0xF8],
      '0101011': [0x1C, 0x56],
      '01010110': [0x20, 0x56],
      '110101101': [0x24, 0xD6, 0x80],
      '111110001101': [0x30, 0xF8, 0xD0],
      '101011001010110': [0x3C, 0xAC, 0xAC],
      '0101011001010110': [0x40, 0x56, 0x56],
      '01010110010101100': [0x44, 0x56, 0x56, 0x00],
      '000000000000000': [0x3C, 0x00, 0x00],
      '1111111111111111': [0x40, 0xFF, 0xFF],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7C, 0xFF, 0xFF, 0xFF, 0xFE],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [0x84, 0xFF, 0xFF, 0xFF, 0xFF, 0x80],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U16, MSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U16, BitOrder.MSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00],
      '1': [0x04, 0x00, 0x80],
      '00': [0x08, 0x00, 0x00],
      '10': [0x08, 0x00, 0x80],
      '01': [0x08, 0x00, 0x40],
      '11': [0x08, 0x00, 0xC0],
      '101': [0x0C, 0x00, 0xA0],
      '0011': [0x10, 0x00, 0x30],
      '0111': [0x10, 0x00, 0x70],
      '1111': [0x10, 0x00, 0xF0],
      '11111': [0x14, 0x00, 0xF8],
      '111110': [0x18, 0x00, 0xF8],
      '0101011': [0x1C, 0x00, 0x56],
      '01010110': [0x20, 0x00, 0x56],
      '110101101': [0x24, 0x80, 0xD6],
      '111110001101': [0x30, 0xD0, 0xF8],
      '101011001010110': [0x3C, 0xAC, 0xAC],
      '0101011001010110': [0x40, 0x56, 0x56],
      '01010110010101100': [0x44, 0x56, 0x56, 0x00, 0x00],
      '000000000000000': [0x3C, 0x00, 0x00],
      '1111111111111111': [0x40, 0xFF, 0xFF],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7C, 0xFF, 0xFF, 0xFE, 0xFF],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [
        0x84,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0x00,
        0x80
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U32, MSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U32, BitOrder.MSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00, 0x00, 0x00],
      '1': [0x04, 0x00, 0x00, 0x00, 0x80],
      '00': [0x08, 0x00, 0x00, 0x00, 0x00],
      '10': [0x08, 0x00, 0x00, 0x00, 0x80],
      '01': [0x08, 0x00, 0x00, 0x00, 0x40],
      '11': [0x08, 0x00, 0x00, 0x00, 0xC0],
      '101': [0x0C, 0x00, 0x00, 0x00, 0xA0],
      '0011': [0x10, 0x00, 0x00, 0x00, 0x30],
      '0111': [0x10, 0x00, 0x00, 0x00, 0x70],
      '1111': [0x10, 0x00, 0x00, 0x00, 0xF0],
      '11111': [0x14, 0x00, 0x00, 0x00, 0xF8],
      '111110': [0x18, 0x00, 0x00, 0x00, 0xF8],
      '0101011': [0x1C, 0x00, 0x00, 0x00, 0x56],
      '01010110': [0x20, 0x00, 0x00, 0x00, 0x56],
      '110101101': [0x24, 0x00, 0x00, 0x80, 0xD6],
      '111110001101': [0x30, 0x00, 0x00, 0xD0, 0xF8],
      '101011001010110': [0x3C, 0x00, 0x00, 0xAC, 0xAC],
      '0101011001010110': [0x40, 0x00, 0x00, 0x56, 0x56],
      '01010110010101100': [0x44, 0x00, 0x00, 0x56, 0x56],
      '000000000000000': [0x3C, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111': [0x40, 0x00, 0x00, 0xFF, 0xFF],
      '00000000000000000': [0x44, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111111111111111111': [0x7C, 0xFE, 0xFF, 0xFF, 0xFF],
      '00000000000000000000000000000000': [0x80, 0x00, 0x00, 0x00, 0x00],
      '111111111111111111111111111111111': [
        0x84,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0x00,
        0x00,
        0x00,
        0x80
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });

  test('BitSequence(U64, MSB) codec works', () {
    final codec = BitSequenceCodec(BitStore.U64, BitOrder.MSB);

    final Map<String, Uint8List> testCases = {
      '0': [0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '1': [0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80],
      '00': [0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '10': [0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80],
      '01': [0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40],
      '11': [0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0],
      '101': [0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA0],
      '0011': [0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30],
      '0111': [0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70],
      '1111': [0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0],
      '11111': [0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF8],
      '111110': [0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF8],
      '0101011': [0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56],
      '01010110': [0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56],
      '110101101': [0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xD6],
      '111110001101': [0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0xF8],
      '101011001010110': [0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAC, 0xAC],
      '0101011001010110': [
        0x40,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x56,
        0x56
      ],
      '01010110010101100': [
        0x44,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x56,
        0x56
      ],
      '000000000000000': [0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
      '1111111111111111': [
        0x40,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0xFF,
        0xFF
      ],
      '00000000000000000': [
        0x44,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111': [
        0x7C,
        0x00,
        0x00,
        0x00,
        0x00,
        0xFE,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000': [
        0x80,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '111111111111111111111111111111111': [
        0x84,
        0x00,
        0x00,
        0x00,
        0x80,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '000000000000000000000000000000000000000000000000000000000000000': [
        0xFC,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
      '1111111111111111111111111111111111111111111111111111111111111111': [
        0x01,
        0x01,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF,
        0xFF
      ],
      '00000000000000000000000000000000000000000000000000000000000000000': [
        0x05,
        0x01,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
      ],
    }.map((key, value) => MapEntry(key, Uint8List.fromList(value)));

    testCases.forEach((key, expectedValue) {
      final bitArray = BitArray.parseBinary(key);

      // Test size hint
      expect(codec.sizeHint(bitArray), expectedValue.lengthInBytes);

      // Test encoding
      final encoded = codec.encode(bitArray);
      expect(encoded, expectedValue);

      // Test decoding
      final decoded = codec.decode(ByteInput(encoded));
      expect(decoded, bitArray);
    });
  });
}