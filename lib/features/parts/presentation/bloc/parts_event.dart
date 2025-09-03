part of 'parts_bloc.dart';

@immutable
sealed class PartsEvent {}

class GetAllParts extends PartsEvent {}
