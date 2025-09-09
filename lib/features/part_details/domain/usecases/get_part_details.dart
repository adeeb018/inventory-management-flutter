import 'package:inventory_management/features/part_details/domain/repositories/part_details_repository.dart';

import '../entities/part_details.dart';

class GetPartDetailsUseCase {
  final PartDetailsRepository repository;

  GetPartDetailsUseCase(this.repository);

  Future<PartDetails> call(String partNumber) {
    return repository.getPartDetails(partNumber);
  }
}
