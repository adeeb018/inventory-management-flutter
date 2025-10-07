part of 'add_part_bloc.dart';

@immutable
sealed class AddPartEvent {}

class GetPartData extends AddPartEvent {
  final String partNumber;
  GetPartData({required this.partNumber});
}

class GetLocationList extends AddPartEvent {
  final String warehouseId;
  GetLocationList({required this.warehouseId});
}

class AddPart extends AddPartEvent {
  final AddPartRequest addPartRequest;
  AddPart({required this.addPartRequest});
}
