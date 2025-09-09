import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../domain/entities/part_details.dart';
import '../../domain/usecases/get_part_details.dart';

part 'part_details_event.dart';
part 'part_details_state.dart';

class PartDetailsBloc extends Bloc<PartDetailsEvent, PartDetailsState> {
  final GetPartDetailsUseCase getPartDetailsUseCase;

  PartDetailsBloc({required this.getPartDetailsUseCase})
      : super(PartDetailsInitial()) {
    on<FetchPartDetails>((event, emit) async {
      emit(PartDetailsLoading());
      try {
        final details = await getPartDetailsUseCase.call(event.partNumber);
        emit(PartDetailsLoaded(details));
      } catch (e) {
        emit(PartDetailsError(e.toString()));
      }
    });
  }
}
