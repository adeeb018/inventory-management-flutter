abstract class PartReportEvent {}

class FetchPartReport extends PartReportEvent {
  final int projectId;

  FetchPartReport(this.projectId);
}
