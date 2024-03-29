import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_flutter/screens/loginscreen.dart';
import 'package:ui_flutter/utils/authentication.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ui_flutter/utils/location.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late GoogleMapController mapController;
  late LatLng? currentLocation = null; //= const LatLng(20.5937, 78.9629);
  User? user;

  void _onMapCreated(GoogleMapController googleMapController) {
    mapController = googleMapController;

    //getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Location.getGeoLocationPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                user!.photoURL.toString(),
              ),
            ),
          ),
          title: Text(user!.displayName.toString()),
          actions: [
            IconButton(
              onPressed: () {
                Authentication.signOutFromGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const LogInScreen();
                }), (route) => true);
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        //floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
        body: currentLocation == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: currentLocation as LatLng, zoom: 10.0)));
  }
}
