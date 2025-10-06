import 'package:inventory_management/features/add_parts/domain/models/part_data/part_data.dart';

abstract class AddPartRepository {
  Future<PartData> getPartData(String partNumber);
}
