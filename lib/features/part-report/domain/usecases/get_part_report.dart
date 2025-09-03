import '../../data/repositories/part_report_repository_impl.dart';
import '../entities/part_report.dart';

class GetPartReport {
  final PartReportRepository repository;

  GetPartReport(this.repository);

  Future<List<PartReportEntity>> call(int projectId) async {
    final list = await repository.fetchPartReport(projectId);
    return list
        .map((p) => PartReportEntity(
              manufacturerPartNumber: p.manufacturerPartNumber,
              partNumber: p.partNumber,
              partDescription: p.partDescription,
              partType: p.partType,
              manufacturer: p.manufacturer,
              quantityUsed: p.quantityUsed,
            ))
        .toList();
  }
}
