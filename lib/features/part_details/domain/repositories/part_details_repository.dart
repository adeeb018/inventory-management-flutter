import '../entities/part_details.dart';

abstract class PartDetailsRepository {
  Future<PartDetails> getPartDetails(String partNumber);
}
