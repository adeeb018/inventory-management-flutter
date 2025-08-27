import '../../domain/entities/part_report.dart';

abstract class PartReportState {}

class PartReportInitial extends PartReportState {}

class PartReportLoading extends PartReportState {}

class PartReportLoaded extends PartReportState {
  final List<PartReportEntity> parts;

  PartReportLoaded(this.parts);
}

class PartReportError extends PartReportState {
  final String message;

  PartReportError(this.message);
}
