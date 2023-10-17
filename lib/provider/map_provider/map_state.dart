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
