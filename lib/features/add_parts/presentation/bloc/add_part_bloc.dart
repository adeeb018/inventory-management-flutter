import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/models/part_data/part_data.dart';
import '../../domain/usecases/add_parts_usecase.dart';

part 'add_part_event.dart';
part 'add_part_state.dart';

class AddPartBloc extends Bloc<AddPartEvent, AddPartState> {
  final GetPartDataUseCase getPartDataUseCase;
  List<String> manufacturerList = [];
  late List<Warehouse> warehouseData;
  late List<Manufacturer> manufacturerData;
  late List<Location> locationData;
  List<String> warehouseList = [];
  List<String> locationList = [];

  AddPartBloc({required this.getPartDataUseCase}) : super(AddPartInitial()) {
    on<GetPartData>((event, emit) async {
      emit(PartDataLoading());
      try {
        final partData = await getPartDataUseCase.call(event.partNumber);

        // Manufacturers
        manufacturerData = partData.data.manufacturers;
        for (var element in manufacturerData) {
          manufacturerList.add(element.name);
        }

        // Warehouse
        warehouseData = partData.data.locations;
        for (var element in warehouseData) {
          warehouseList.add(element.warehouseName);
        }

        emit(PartDataLoaded(
            partData, manufacturerData, warehouseData, const []));
        // emit(ManufacturerList(manufacturerList));
        // emit(WarehouseList(warehouseList));
      } catch (e) {
        emit(PartDataError(e.toString()));
      }
    });

    on<GetLocationList>((event, emit) {
      final currentState = state as PartDataLoaded;
      final warehouseId = event.warehouseId;
      // final locationData = [];
      // final locationData = warehouseData
      // final locationData = warehouseData.map((warehouse) {
      //   if (warehouse.warehouseId.toString() == warehouseId) {
      //     return warehouse.locationInWarehouse;
      //   }
      // }).toList();
      // print("warehouseId: $warehouseId");
      // for (var element in warehouseData) {
      //   if (element.warehouseId.toString() == warehouseId) {
      //     locationData.addAll(element.locationInWarehouse);
      //   }
      // }

      // print("locationData: $locationData");

      // for (var element in locationData) {
      //   for (var element in element) {
      //     locationList.add(element.locationName);
      //   }
      // }

      locationData = warehouseData
          .where((warehouse) => warehouse.warehouseId.toString() == warehouseId)
          .first
          .locationInWarehouse;

      print("locationData: $locationData");

      // print(locationList);
      emit(currentState.copyWith(locationList: locationData));
    });
  }
}
