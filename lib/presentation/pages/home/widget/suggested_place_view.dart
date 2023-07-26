import 'package:choose_app/domain/domain.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/presentation.dart';
import 'package:choose_app/presentation/utils/border_radius.dart';
import 'package:choose_app/presentation/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class SuggestedPlaceView extends StatelessWidget {
  const SuggestedPlaceView({
    required this.place,
    required this.userLocation,
    required this.userChoice,
    required this.onClose,
    super.key,
  });

  final PlaceEntity place;
  final Position userLocation;
  final ChoiceEntity userChoice;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                place.name,
                style: context.textTheme.bold.titleMedium,
              ),
              const Spacer(),
              RatingBarIndicator(
                itemSize: smallSize,
                rating: place.rating,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
          Text('$_distanceToSuggestedPlace km'),
          VSpace.small(),
          _MapView(place: place, userLocation: userLocation),
          VSpace.small(),
          Align(
            child: SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: () => _onPressedCheckOtherPlaces(context),
                child: Text(context.l10n.home__check_other_places),
              ),
            ),
          ),
          VSpace.small(),
        ],
      ),
    );
  }

  void _onPressedCheckOtherPlaces(BuildContext context) {
    MapsLauncher.launchQuery(userChoice.name);
    onClose();
  }

  String get _distanceToSuggestedPlace =>
      _calculateDistanceInKm().toStringAsFixed(2);

  double _calculateDistanceInKm() =>
      Geolocator.distanceBetween(
        place.coordinates.latitude,
        place.coordinates.longitude,
        userLocation.latitude,
        userLocation.longitude,
      ) /
      1000;
}

class _MapView extends StatelessWidget {
  const _MapView({
    required this.place,
    required this.userLocation,
  });

  final PlaceEntity place;
  final Position userLocation;

  @override
  Widget build(BuildContext context) => Expanded(
        child: ClipRRect(
          borderRadius: borderRadiusMedium,
          child: GoogleMap(
            polylines: {_polyline()},
            initialCameraPosition: _initialCameraPosition(),
            markers: {
              _suggestedPlaceMarker(context),
              _userPositionMarker(context)
            },
            onMapCreated: _onMapCreated,
          ),
        ),
      );

  void _onMapCreated(GoogleMapController controller) => Future.delayed(
        mapAnimationDelay,
        () => _animateToSuggestedPlace(controller),
      );

  void _animateToSuggestedPlace(GoogleMapController controller) =>
      controller.animateCamera(
        CameraUpdate.newCameraPosition(_suggestedPlacePosition()),
      );

  CameraPosition _initialCameraPosition() => CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: defaultCameraZoom,
      );

  CameraPosition _suggestedPlacePosition() => CameraPosition(
        target: LatLng(place.coordinates.latitude, place.coordinates.longitude),
        zoom: defaultCameraZoom,
      );

  Polyline _polyline() => Polyline(
        polylineId: const PolylineId(mapPolylineId),
        color: Colors.red,
        points: [
          LatLng(place.coordinates.latitude, place.coordinates.longitude),
          LatLng(userLocation.latitude, userLocation.longitude),
        ],
      );

  Marker _suggestedPlaceMarker(BuildContext context) => Marker(
        markerId: const MarkerId(suggestedPlaceMarkerId),
        position: LatLng(
          place.coordinates.latitude,
          place.coordinates.longitude,
        ),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: context.l10n.home__suggested_place,
        ),
      );

  Marker _userPositionMarker(BuildContext context) => Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: const MarkerId(userPositionMarkerId),
        position: LatLng(
          userLocation.latitude,
          userLocation.longitude,
        ),
        infoWindow: InfoWindow(title: context.l10n.general__you),
      );
}
