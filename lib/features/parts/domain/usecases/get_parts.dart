import '../entities/parts.dart';
import '../repositories/parts_repository.dart';

class GetPartsUseCase {
  final PartsRepository repository;

  GetPartsUseCase(this.repository);

  Future<List<Parts>> call() {
    return repository.getAllParts();
  }
}
