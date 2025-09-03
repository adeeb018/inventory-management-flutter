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
        // accessToken = userToken.accessToken;
        // refreshToken = userToken.refreshToken;
        // save securely
        // await secureStorage.write(key: 'auth_token', value: token);
        // await secureStorage.write(key: 'accessToken', value: accessToken);
        // await secureStorage.write(key: 'refreshToken', value: refreshToken);
        emit(PartsLoaded(getParts));
      } catch (e) {
        emit(PartsError(e.toString()));
      }
    });
  }
}
