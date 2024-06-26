part of descriptors;

class CompactDescriptor extends TypeDescriptor {
  final int _id;
  const CompactDescriptor(this._id);

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    return refs.bigInt.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return refs.compactBigIntCodec.type as TypeReference;
  }

  @override
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
    final value = CompactBigIntCodec.codec.decode(input);
    return bigIntToExpression(value).asLiteralValue();
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    return refs.bigInt.type as TypeReference;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
