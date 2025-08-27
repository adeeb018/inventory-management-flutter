import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_part_report.dart';
import 'part_report_event.dart';
import 'part_report_state.dart';

class PartReportBloc extends Bloc<PartReportEvent, PartReportState> {
  final GetPartReport getPartReport;

  PartReportBloc({required this.getPartReport}) : super(PartReportInitial()) {
    on<FetchPartReport>((event, emit) async {
      emit(PartReportLoading());
      try {
        final parts = await getPartReport(event.projectId);
        emit(PartReportLoaded(parts));
      } catch (e) {
        emit(PartReportError(e.toString()));
      }
    });
  }
}
