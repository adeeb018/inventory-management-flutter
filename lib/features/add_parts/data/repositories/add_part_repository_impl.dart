import 'package:inventory_management/features/add_parts/domain/models/part_data/part_data.dart';
import 'package:inventory_management/features/add_parts/domain/repositories/add_part_repository.dart';

import '../../../../core/constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/add_part_request.dart';

class AddPartRepositoryImpl implements AddPartRepository {
  final ApiClient apiClient;

  AddPartRepositoryImpl({required this.apiClient});

  @override
  Future<PartData> getPartData(String partNumber) async {
    try {
      final res =
          await apiClient.dio.get(AppConstants.getPartDataUrl(partNumber));
      print(res);
      final data = res.data;
      if (data is String) {
        return partDataModelFromJson(data);
      } else if (data is Map<String, dynamic>) {
        return PartData.fromJson(data);
      } else {
        return PartData.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      throw Exception('Part details fetch failed: $e');
    }
  }

  @override
  Future<void> addPartData(AddPartRequest addPartRequest) async {
    try {
      final res = await apiClient.dio
          .post(AppConstants.addParts, data: addPartRequest.toJson());
      print("addPartData: $res");
    } catch (e) {
      throw Exception('Part add failed: $e');
    }
  }
}
