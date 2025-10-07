import 'package:inventory_management/features/add_parts/domain/models/part_data/part_data.dart';

import '../models/add_part_request.dart';

abstract class AddPartRepository {
  Future<PartData> getPartData(String partNumber);
  Future<void> addPartData(AddPartRequest addPartRequest);
}
