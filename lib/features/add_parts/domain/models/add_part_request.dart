import 'dart:convert';

AddPartRequest partDataModelFromJson(String str) =>
    AddPartRequest.fromJson(json.decode(str));

String partDataModelToJson(AddPartRequest data) => json.encode(data.toJson());

class AddPartRequest {
  final String partNumber;
  final String description;
  final String partType;
  final int manufacturerId;
  final String manufacturerPartNumber;
  final double unitCost;
  final String currency;
  final int initialStock;
  final int locationId;
  final int warehouseId;
  final int? receivedForProjectId;
  final int createdBy;

  AddPartRequest({
    required this.partNumber,
    required this.description,
    required this.partType,
    required this.manufacturerId,
    required this.manufacturerPartNumber,
    required this.unitCost,
    required this.currency,
    required this.initialStock,
    required this.locationId,
    required this.warehouseId,
    this.receivedForProjectId,
    required this.createdBy,
  });

  /// Create an instance from JSON
  factory AddPartRequest.fromJson(Map<String, dynamic> json) {
    return AddPartRequest(
      partNumber: json['part_number'] as String,
      description: json['description'] as String,
      partType: json['part_type'] as String,
      manufacturerId: json['manufacturer_id'] as int,
      manufacturerPartNumber: json['manufacturer_part_number'] as String,
      unitCost: (json['unit_cost'] as num).toDouble(),
      currency: json['currency'] as String,
      initialStock: json['initial_stock'] as int,
      locationId: json['location_id'] as int,
      warehouseId: json['warehouse_id'] as int,
      receivedForProjectId: json['received_for_project_id'] as int?,
      createdBy: json['created_by'] as int,
    );
  }

  /// Convert the object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'part_number': partNumber,
      'description': description,
      'part_type': partType,
      'manufacturer_id': manufacturerId,
      'manufacturer_part_number': manufacturerPartNumber,
      'unit_cost': unitCost,
      'currency': currency,
      'initial_stock': initialStock,
      'location_id': locationId,
      'warehouse_id': warehouseId,
      'received_for_project_id': receivedForProjectId,
      'created_by': createdBy,
    };
  }
}
