part of generators;

typedef BasePath = String;

abstract class TypeDescriptor {
  const TypeDescriptor();

  static int _idSequence = 1;
  static Map<TypeDescriptor, int> generatorToId = {};
  static Map<String, TypeReference> jsonTypeCache = {};

  static String _cachedKey(BasePath from, Set<TypeDescriptor> visited) {
    bool created = false;
    final ids = <int>[];
    for (final generator in visited) {
      int? id = generatorToId[generator];
      if (id == null) {
        id = _idSequence++;
        generatorToId[generator] = id;
        created = true;
      }
      ids.add(id);
    }
    ids.sort();
    final key = '$from | ${ids.join('.')}';
    if (created && jsonTypeCache.containsKey(key)) {
      throw Exception('Error, cached key collision: "$key"');
    }
    return key;
  }

  static TypeReference cacheOrCreate(BasePath from, Set<TypeDescriptor> visited,
      TypeReference Function() callback) {
    final String hash = _cachedKey(from, visited);
    TypeReference? type = jsonTypeCache[hash];
    if (type == null) {
      type = callback();
      jsonTypeCache[hash] = type;
    }
    return type;
  }

  static Map<int, TypeDescriptor> fromTypes(
      List<metadata.TypeMetadata> registry, String typesPath) {
    return parseTypes(registry, typesPath);
  }

  /// Returns the id of type in the registry.
  int id();

  Expression encode(BasePath from, Expression obj,
      [Expression output = const Reference('output')]) {
    return codecInstance(from).property('encodeTo').call([obj, output]);
  }

  Expression decode(BasePath from,
      [Expression input = const Reference('input')]) {
    return codecInstance(from).property('decode').call([input]);
  }

  TypeReference primitive(BasePath from);

  TypeReference codec(BasePath from);

  Expression codecInstance(String from) {
    return codec(from).property('codec');
  }

  Expression valueFrom(BasePath from, Input input, {bool constant = false});

  TypeReference jsonType(BasePath from,
      [Set<TypeDescriptor> visited = const {}]);

  Expression instanceToJson(BasePath from, Expression obj);

  // GeneratedOutput? generated() {
  //   return null;
  // }
}

abstract class TypeBuilder extends TypeDescriptor {
  String filePath;

  TypeBuilder(this.filePath);

  GeneratedOutput build();
}

class GeneratedOutput {
  final List<TypeDef> typedefs;
  final List<Class> classes;
  final List<Enum> enums;

  static final _dartfmt = DartFormatter();

  const GeneratedOutput(
      {required this.classes, required this.enums, required this.typedefs});

  String build() {
    final library3 = Library((b) => b
      ..body.addAll(typedefs)
      ..body.addAll(enums)
      ..body.addAll(classes));

    final code = library3
        .accept(DartEmitter.scoped(useNullSafetySyntax: true))
        .toString();
    try {
      return _dartfmt.format(code);
    } catch (error) {
      return code;
    }
  }

  GeneratedOutput merge(GeneratedOutput other) {
    typedefs.addAll(other.typedefs);
    classes.addAll(other.classes);
    enums.addAll(other.enums);
    return this;
  }
}

class LazyLoader {
  final List<Function(Map<int, TypeDescriptor>)> loaders = [];
  final Map<int, int> aliases = {};
  LazyLoader();

  void addLoader(Function(Map<int, TypeDescriptor>) loader) {
    loaders.add(loader);
  }
}

class Field {
  late String? originalName;
  late String sanitizedName;
  late TypeDescriptor codec;
  late List<String> docs;

  Field({required this.originalName, required this.codec, required this.docs}) {
    // TODO: detect collisions
    // ex: 'foo_bar' and `fooBar` will collide
    if (originalName != null) {
      sanitizedName = toFieldName(originalName!);
    }
  }

  Field._lazy({required String? name, required this.docs}) {
    originalName = name;
    if (originalName != null) {
      sanitizedName = toFieldName(originalName!);
    }
  }

  factory Field.lazy({
    required LazyLoader loader,
    required int codec,
    required String? name,
    List<String> docs = const [],
  }) {
    final field = Field._lazy(name: name, docs: docs);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      field.codec = register[codec]!;
    });
    return field;
  }

  String originalOrSanitizedName() {
    return originalName ?? sanitizedName;
  }

  static String toFieldName(String name) {
    return sanitize(ReCase(name).camelCase);
  }
}