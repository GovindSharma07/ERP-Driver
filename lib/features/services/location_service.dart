import 'dart:async';
import 'dart:convert';

import 'package:location/location.dart';
import 'package:open_settings/open_settings.dart';
import "package:http/http.dart" as http;

Location _locationController = Location();
StreamSubscription<LocationData>? locationSubscription;


Future<int> checkLocationService() async {
  bool isServiceEnabled;
  PermissionStatus permissionGranted;

  //Checking whether device has service enabled for application or not
  isServiceEnabled = await _locationController.serviceEnabled();

  //if service is not enabled then redirect to settings
  if (isServiceEnabled == false) {
    OpenSettings.openLocationSourceSetting();
    Future.delayed(const Duration(seconds: 5));
    isServiceEnabled = await _locationController.serviceEnabled();
  }

  //if service is enabled for device then  request for service
  if (isServiceEnabled) {
    isServiceEnabled = await _locationController.requestService();
  } else {
    return 0;
  }

  //check is permission granted or not
  permissionGranted = await _locationController.hasPermission();

  //if app have not the permission then ask
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await _locationController.requestPermission();

    //if still not granted return
    if (permissionGranted != PermissionStatus.granted) {
      return 0;
    }
    changeLocationSetting(50);
    return 1;
  }
  changeLocationSetting(50);
  return 1;
}

void changeLocationSetting(double distanceFilter) {
  _locationController.changeSettings(distanceFilter: distanceFilter);
}

void startLocationListening(List<String> tokens) async {
  var url =
      Uri.parse("https://fcm-notification-server.onrender.com/api/sendLocationToMultiUser");

  locationSubscription =
      _locationController.onLocationChanged.listen((event) async {
    var  body = {
      "tokens" : tokens,
      "lng": "${event.longitude}",
      "lat": "${event.latitude}"
    };

    print(jsonEncode(body));
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    print(response.statusCode);
    print(response.body);
    });
}

void stopLocationListening() {
  if (locationSubscription != null) {
    locationSubscription!.cancel();
  }
}
