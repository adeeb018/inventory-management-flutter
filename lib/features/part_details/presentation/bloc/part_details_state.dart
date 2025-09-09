part of 'part_details_bloc.dart';

@immutable
sealed class PartDetailsState {}

final class PartDetailsInitial extends PartDetailsState {}

final class PartDetailsLoading extends PartDetailsState {}

final class PartDetailsLoaded extends PartDetailsState {
  final PartDetails details;
  PartDetailsLoaded(this.details);
}

final class PartDetailsError extends PartDetailsState {
  final String message;
  PartDetailsError(this.message);
}
