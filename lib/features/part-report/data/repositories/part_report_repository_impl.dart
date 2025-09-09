import 'package:inventory_management/core/constants.dart';

import '../../../../core/network/api_client.dart';
import '../models/part_report_model.dart';

abstract class PartReportRepository {
  Future<List<PartReport>> fetchPartReport(int projectId);
}

class PartReportRepositoryImpl implements PartReportRepository {
  final ApiClient apiClient;

  PartReportRepositoryImpl({required this.apiClient});

  @override
  Future<List<PartReport>> fetchPartReport(int projectId) async {
    final res =
        await apiClient.dio.get(AppConstants.getPartReportUrl(projectId));
    final data = res.data as List;
    return data
        .map((json) => PartReport.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
