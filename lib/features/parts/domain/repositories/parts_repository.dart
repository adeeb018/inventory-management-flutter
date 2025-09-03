import '../entities/parts.dart';

abstract class PartsRepository {
  Future<List<Parts>> getAllParts();
}
