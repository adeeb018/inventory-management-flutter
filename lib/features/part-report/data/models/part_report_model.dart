class PartReport {
  final String manufacturerPartNumber;
  final String partNumber;
  final String partDescription;
  final String partType;
  final String manufacturer;
  final int quantityUsed;

  PartReport({
    required this.manufacturerPartNumber,
    required this.partNumber,
    required this.partDescription,
    required this.partType,
    required this.manufacturer,
    required this.quantityUsed,
  });

  factory PartReport.fromJson(Map<String, dynamic> json) => PartReport(
        manufacturerPartNumber: json['manufacturer_part_number'],
        partNumber: json['part_number'],
        partDescription: json['part_description'],
        partType: json['part_type'],
        manufacturer: json['manufacturer'],
        quantityUsed: json['quantity_used'],
      );
}
