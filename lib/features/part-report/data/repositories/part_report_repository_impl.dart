import 'package:dio/dio.dart';
import 'package:inventory_management/core/constants.dart';

import '../models/part_report_model.dart';

abstract class PartReportRepository {
  Future<List<PartReport>>  fetchPartReport(int projectId);
}

class PartReportRepositoryImpl implements PartReportRepository {
  final String token;
  final Dio _dio;

  PartReportRepositoryImpl({required this.token})
      : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    headers: {'Authorization': 'Bearer $token'},
  ));


  @override
  Future<List<PartReport>> fetchPartReport(int projectId) async {
    final res = await _dio.get('/projects/$projectId/part-report');
    final data = res.data as List;
    return data
        .map((json) => PartReport.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
