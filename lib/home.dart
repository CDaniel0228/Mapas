import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'constantes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late List<MapLatLng> polyline;
  late List<PolylineModel> polylines;
  late MapZoomPanBehavior zoomPanBehavior;

  @override
  void initState() {
    polyline = <MapLatLng>[
      MapLatLng(2.457151464488912, -76.87504015887973), //Tambo
      MapLatLng(2.5339828175442816, -76.6388341158582), // Popayán
      MapLatLng(2.3501290274993125, -76.66629992613251), // Timbío
      MapLatLng(2.166251022456309, -76.9519444519565), // El bordo
    ];

    // polylines = <List<MapLatLng>>[polyline];
    polylines = <PolylineModel>[
      PolylineModel(polyline, Colors.purple, 3),
    ];

    zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 8,
      focalLatLng:
          MapLatLng(2.457446092933111, -76.60710953838645), //2.9273, -76.6110
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Expanded(
                child: SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  sublayers: [
                    MapPolylineLayer(
                      polylines: List<MapPolyline>.generate(
                        polylines.length,
                        (int index) {
                          return MapPolyline(
                            points: polylines[index].points,
                            color: polylines[index].color,
                            width: polylines[index].width,
                          );
                        },
                      ).toSet(),
                    ),
                  ],
                  zoomPanBehavior: zoomPanBehavior,
                ),
              ],
            ))),
        Container(
          height: 300,
          child: Column(
            children: [
              const Text(
                'OFERTA DE TRANSPORTE',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: principalVerde,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Transporte',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: principalVerde,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: principalNaranja,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Rechazar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class PolylineModel {
  PolylineModel(this.points, this.color, this.width);
  final List<MapLatLng> points;
  final Color color;
  final double width;
}
