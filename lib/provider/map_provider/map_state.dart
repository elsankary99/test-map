part of 'map_provider.dart';

abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapDataFetched extends MapState {}

class MapError extends MapState {
  final String message;
  const MapError(this.message);
}

//* get current location
class GetCurrentLocationLoading extends MapState {}

class GetCurrentLocationSuccess extends MapState {}

class GetCurrentLocationError extends MapState {
  final String message;
  const GetCurrentLocationError(this.message);
}
