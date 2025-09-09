import 'package:inventory_management/core/constants.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/parts.dart';
import '../../domain/repositories/parts_repository.dart';

class PartsRepositoryImpl implements PartsRepository {
  final ApiClient apiClient;

  PartsRepositoryImpl({required this.apiClient});

  @override
  Future<List<Parts>> getAllParts() async {
    try {
      final res = await apiClient.dio.get(AppConstants.getPartsUrl);
      final List<dynamic> data = res.data;
      return data
          .map((item) => Parts(
                partId: item['part_id'],
                partNumber: item['part_number'],
                description: item['description'],
                partType: item['part_type'],
              ))
          .toList();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
