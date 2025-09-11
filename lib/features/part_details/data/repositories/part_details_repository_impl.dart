import 'package:inventory_management/core/constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/part_details.dart';
import '../../domain/repositories/part_details_repository.dart';

class PartDetailsRepositoryImpl implements PartDetailsRepository {
  final ApiClient apiClient;

  PartDetailsRepositoryImpl({required this.apiClient});

  @override
  Future<PartDetails> getPartDetails(String partNumber) async {
    try {
      final res =
          await apiClient.dio.get(AppConstants.getPartDetailsUrl(partNumber));
      final data = res.data;
      if (data is String) {
        return partReportModelFromJson(data);
      } else if (data is Map<String, dynamic>) {
        return PartDetails.fromJson(data);
      } else {
        return PartDetails.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      throw Exception('Part details fetch failed: $e');
    }
  }
}
