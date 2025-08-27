class PartReportEntity {
  final String manufacturerPartNumber;
  final String partNumber;
  final String partDescription;
  final String partType;
  final String manufacturer;
  final int quantityUsed;

  PartReportEntity({
    required this.manufacturerPartNumber,
    required this.partNumber,
    required this.partDescription,
    required this.partType,
    required this.manufacturer,
    required this.quantityUsed,
  });
}
