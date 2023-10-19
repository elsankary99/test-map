part of 'map_provider.dart';

abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {}

//* get place details
class GetPlaceDetailsLoading extends MapState {}

class GetPlaceDetailsSuccess extends MapState {
  final PlaceDetailsModel place;

  GetPlaceDetailsSuccess({required this.place});
}

class GetPlaceDetailsError extends MapState {
  final String message;
  const GetPlaceDetailsError(this.message);
}

//* get place details
class AddMarker extends MapState {}

//* get direction place
class DirectionPlaceLoading extends MapState {}

class DirectionPlaceSuccess extends MapState {
  final DirectionPlaceModel direction;

  DirectionPlaceSuccess({required this.direction});
}

class DirectionPlaceError extends MapState {
  final String message;
  const DirectionPlaceError(this.message);
}
