class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermisson permisson;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }
    permisson = await Geolocator.checkPermission();
    if (permisson == LocationPermission.denied) {
      permisson = await Geolocator.requestPermission();
      if (permisson == LocationPermission.denied) {
        return Future.error("Location Permission is denied");
      }
    }
    if (permisson == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permissions are permanently denied, we cannot request permission");
    }

    return await Geolocator.getCurrentPosition();
  }
}
