import 'dart:convert';

PartData partDataModelFromJson(String str) =>
    PartData.fromJson(json.decode(str));

String partDataModelToJson(PartData data) => json.encode(data.toJson());

class PartData {
  final bool success;
  final PartDataData data;

  PartData({
    required this.success,
    required this.data,
  });

  factory PartData.fromJson(Map<String, dynamic> json) {
    return PartData(
      success: json['success'],
      data: PartDataData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

/// 🔹 Core PartData
class PartDataData {
  final int partId;
  final String partNumber;
  final String partType;
  final String description;
  final List<Manufacturer> manufacturers;
  final List<Warehouse> locations;

  PartDataData({
    required this.partId,
    required this.partNumber,
    required this.partType,
    required this.description,
    required this.manufacturers,
    required this.locations,
  });

  factory PartDataData.fromJson(Map<String, dynamic> json) {
    return PartDataData(
      partId: json['part_id'],
      partNumber: json['part_number'],
      partType: json['part_type'],
      description: json['description'],
      manufacturers: (json['manufacturers'] as List)
          .map((e) => Manufacturer.fromJson(e))
          .toList(),
      locations: (json['locations'] as List)
          .map((e) => Warehouse.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'part_id': partId,
      'part_number': partNumber,
      'part_type': partType,
      'description': description,
      'manufacturers': manufacturers.map((e) => e.toJson()).toList(),
      'locations': locations.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Manufacturer
class Manufacturer {
  final int manufacturerId;
  final String name;

  Manufacturer({
    required this.manufacturerId,
    required this.name,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      manufacturerId: json['manufacturer_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manufacturer_id': manufacturerId,
      'name': name,
    };
  }
}

/// 🔹 Warehouse
class Warehouse {
  final int warehouseId;
  final String warehouseName;
  final List<Location> locationInWarehouse;

  Warehouse({
    required this.warehouseId,
    required this.warehouseName,
    required this.locationInWarehouse,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      warehouseId: json['warehouse_id'],
      warehouseName: json['warehouse_name'],
      locationInWarehouse: (json['location_in_warehouse'] as List)
          .map((e) => Location.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'warehouse_id': warehouseId,
      'warehouse_name': warehouseName,
      'location_in_warehouse':
          locationInWarehouse.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🔹 Location
class Location {
  final int locationId;
  final String locationName;

  Location({
    required this.locationId,
    required this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['location_id'],
      locationName: json['location_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'location_name': locationName,
    };
  }
}
