part of 'part_details_bloc.dart';

@immutable
sealed class PartDetailsEvent {}

class FetchPartDetails extends PartDetailsEvent {
  final String partNumber;
  FetchPartDetails(this.partNumber);
}
