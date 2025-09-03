part of 'parts_bloc.dart';

@immutable
sealed class PartsState {}

final class PartsInitial extends PartsState {}

final class PartsLoading extends PartsState {}

final class PartsLoaded extends PartsState {
  final List<Parts> parts;

  PartsLoaded(this.parts);
}

final class PartsError extends PartsState {
  final String message;

  PartsError(this.message);
}
