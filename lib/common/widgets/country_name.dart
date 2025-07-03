//------------------City name----------------------

import 'package:afriqueen/services/location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CountryName extends StatefulWidget {
  const CountryName({super.key});

  @override
  State<CountryName> createState() => _CountryNameState();
}

class _CountryNameState extends State<CountryName> {
  Future<List<Placemark>?>? _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getLocation();
  }

  Future<List<Placemark>?> _getLocation() async {
    final Position position = await UserLocation.determinePosition();
    return await UserLocation.geoCoding(position);
  }

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context).textTheme;
    return FutureBuilder<List<Placemark>?>(
      future: _locationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink(); // Show loading indicator
        } else if (snapshot.hasError) {
          return PlatformText(
            'Error: ${snapshot.error}',
            style: theme.bodySmall,
            overflow: TextOverflow.ellipsis,
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final currentLocation = snapshot.data!;

          return Center(
            child: PlatformText(
              currentLocation.first.country!.tr,
              style: theme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else {
          return PlatformText(
            'Location not available',
            style: theme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ); // Handle null data
        }
      },
    );
  }
}
