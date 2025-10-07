import 'package:inventory_management/features/add_parts/domain/models/part_data/part_data.dart';
import '../models/add_part_request.dart';
import '../repositories/add_part_repository.dart';

class GetPartDataUseCase {
  final AddPartRepository repository;

  GetPartDataUseCase(this.repository);

  Future<PartData> call(String partNumber) {
    return repository.getPartData(partNumber);
  }

  Future<void> addPart(AddPartRequest addPartRequest) {
    return repository.addPartData(addPartRequest);
  }
}
