import 'dart:convert';

class Parts {
  int? partId;
  String? partNumber;
  String? description;
  String? partType;

  Parts({this.partId, this.partNumber, this.description, this.partType});

  // factory Parts.fromMap(Map<String, dynamic> data) => Parts(
  //       partId: data['part_id'] as int?,
  //       partNumber: data['part_number'] as String?,
  //       description: data['description'] as String?,
  //       partType: data['part_type'] as String?,
  //     );

  // Map<String, dynamic> toMap() => {
  //       'part_id': partId,
  //       'part_number': partNumber,
  //       'description': description,
  //       'part_type': partType,
  //     };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Parts].
  // factory Parts.fromJson(String data) {
  //   return Parts.fromMap(json.decode(data) as Map<String, dynamic>);
  // }

  // /// `dart:convert`
  // ///
  // /// Converts [Parts] to a JSON string.
  // String toJson() => json.encode(toMap());
}
