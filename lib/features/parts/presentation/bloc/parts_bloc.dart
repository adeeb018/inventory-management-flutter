import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/parts.dart';
import '../../domain/usecases/get_parts.dart';

part 'parts_event.dart';
part 'parts_state.dart';

class PartsBloc extends Bloc<PartsEvent, PartsState> {
  final GetPartsUseCase getPartsUseCase;
  PartsBloc({required this.getPartsUseCase}) : super(PartsInitial()) {
    on<GetAllParts>((event, emit) async {
      emit(PartsLoading());
      try {
        final getParts = await getPartsUseCase.call();
        emit(PartsLoaded(getParts));
      } catch (e) {
        emit(PartsError(e.toString()));
      }
    });
  }
}
