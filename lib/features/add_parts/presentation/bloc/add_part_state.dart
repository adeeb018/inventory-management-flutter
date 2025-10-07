part of 'add_part_bloc.dart';

// Assuming AddPartState is the base abstract class
@immutable
sealed class AddPartState extends Equatable {
  const AddPartState();
  @override
  List<Object?> get props => [];
}

final class AddPartInitial extends AddPartState {}

final class PartDataLoading extends AddPartState {}

// final class PartDataLoaded extends AddPartState {
//   final PartData partData;
//   final List<String> manufacturerList;
//   final List<String> warehouseList;
//   final List<String> locationList;

//   PartDataLoaded(this.partData, this.manufacturerList, this.warehouseList,
//       this.locationList);
// }

final class PartDataLoaded extends AddPartState {
  final PartData partData;
  final List<Manufacturer> manufacturerList;
  final List<Warehouse> warehouseList;
  final List<Location> locationList;

  const PartDataLoaded(
    this.partData,
    this.manufacturerList,
    this.warehouseList,
    this.locationList,
  );

  // 1. Implement copyWith
  PartDataLoaded copyWith({
    PartData? partData,
    List<Manufacturer>? manufacturerList,
    List<Warehouse>? warehouseList,
    List<Location>? locationList,
  }) {
    return PartDataLoaded(
      // Use the new value if provided, otherwise use the current value (`this.partData`)
      partData ?? this.partData,
      manufacturerList ?? this.manufacturerList,
      warehouseList ?? this.warehouseList,
      locationList ?? this.locationList,
    );
  }

  // 2. Implement props for Equatable
  @override
  List<Object?> get props => [
        partData,
        manufacturerList,
        warehouseList,
        locationList,
      ];
}

final class PartDataError extends AddPartState {
  final String message;

  PartDataError(this.message);
}

final class PartDataAdded extends AddPartState {
  final String message;

  PartDataAdded(this.message);
}

final class PartDataAddError extends AddPartState {
  final String message;
  PartDataAddError(this.message);
}
