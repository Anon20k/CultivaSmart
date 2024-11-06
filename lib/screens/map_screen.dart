import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoianRlcnJvIiwiYSI6ImNseHd5aGFtODJ3dDcya29kMmQyYmgzYm4ifQ.WZOOn5y-E6bo7NR1Sqk4RQ';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;
  List<LatLng> points = [];

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  double calculateArea(List<LatLng> points) {
    double area = 0.0;
    int numPoints = points.length;

    for (int i = 0; i < numPoints; i++) {
      int j = (i + 1) % numPoints;

      double lat1 = points[i].latitudeInRad;
      double lon1 = points[i].longitudeInRad;
      double lat2 = points[j].latitudeInRad;
      double lon2 = points[j].longitudeInRad;

      area += (lon2 - lon1) * (2 + math.sin(lat1) + math.sin(lat2));
    }

    area = area * 6378137.0 * 6378137.0 / 2.0;
    return area.abs();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void clearMarkers() {
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: Color(0xFF448AFF),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: clearMarkers,
          ),
        ],
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                center: myPosition,
                minZoom: 5,
                maxZoom: 35,
                zoom: 18,
                onTap: (tapPosition, point) {
                  setState(() {
                    points.add(point);
                  });
                },
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': 'mapbox/streets-v12'
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: myPosition!,
                      builder: (context) {
                        return Container(
                          child: const Icon(
                            Icons.person_pin,
                            color: Colors.blueAccent,
                            size: 40,
                          ),
                        );
                      },
                    ),
                    ...points.map((point) => Marker(
                          point: point,
                          builder: (context) {
                            return Container(
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                            );
                          },
                        )),
                  ],
                ),
                if (points.length > 2)
                  PolygonLayer(
                    polygons: [
                      Polygon(
                        points: points,
                        borderStrokeWidth: 2,
                        borderColor: Colors.red,
                        color: Colors.red.withOpacity(0.3),
                      )
                    ],
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (points.length > 2) {
            double areaSqMeters = calculateArea(points);
            double areaHectares = areaSqMeters / 10000;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Área de la zona'),
                  content: Text(
                      'El área de la zona es:\n${areaSqMeters.toStringAsFixed(2)} metros cuadrados\n${areaHectares.toStringAsFixed(2)} hectáreas.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    )
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.calculate),
      ),
    );
  }
}
