import 'dart:convert';

PartDetails partReportModelFromJson(String str) =>
    PartDetails.fromJson(json.decode(str));

String partReportModelToJson(PartDetails data) => json.encode(data.toJson());

class PartDetails {
  String partNumber;
  String partType;
  String description;
  int totalStockIncludingAlternates;
  List<ManufacturerPart> manufacturerParts;

  PartDetails({
    required this.partNumber,
    required this.partType,
    required this.description,
    required this.totalStockIncludingAlternates,
    required this.manufacturerParts,
  });

  factory PartDetails.fromJson(Map<String, dynamic> json) => PartDetails(
        partNumber: json["part_number"],
        partType: json["part_type"],
        description: json["description"],
        totalStockIncludingAlternates: json["total_stock_including_alternates"],
        manufacturerParts: List<ManufacturerPart>.from(
            json["manufacturer_parts"]
                .map((x) => ManufacturerPart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "part_number": partNumber,
        "part_type": partType,
        "description": description,
        "total_stock_including_alternates": totalStockIncludingAlternates,
        "manufacturer_parts":
            List<dynamic>.from(manufacturerParts.map((x) => x.toJson())),
      };
}

class ManufacturerPart {
  String manufacturerPartNumber;
  String manufacturer;
  int stock;
  List<Location> locations;

  ManufacturerPart({
    required this.manufacturerPartNumber,
    required this.manufacturer,
    required this.stock,
    required this.locations,
  });

  factory ManufacturerPart.fromJson(Map<String, dynamic> json) =>
      ManufacturerPart(
        manufacturerPartNumber: json["manufacturer_part_number"],
        manufacturer: json["manufacturer"],
        stock: json["stock"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "manufacturer_part_number": manufacturerPartNumber,
        "manufacturer": manufacturer,
        "stock": stock,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class Location {
  String warehouse;
  String location;
  int quantity;

  Location({
    required this.warehouse,
    required this.location,
    required this.quantity,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        warehouse: json["warehouse"],
        location: json["location"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "warehouse": warehouse,
        "location": location,
        "quantity": quantity,
      };
}
