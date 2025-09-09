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
      return partReportModelFromJson(res.data);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
