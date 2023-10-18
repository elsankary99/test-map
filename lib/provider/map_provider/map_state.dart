part of 'map_provider.dart';

abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {}

//* get place details
class GetPlaceDetailsLoading extends MapState {}

class GetPlaceDetailsSuccess extends MapState {
  final Location location;

  GetPlaceDetailsSuccess({required this.location});
}

class GetPlaceDetailsError extends MapState {
  final String message;
  const GetPlaceDetailsError(this.message);
}

//* get place details
class AddMarker extends MapState {}
