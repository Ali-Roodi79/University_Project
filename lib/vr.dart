import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Vrpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return vrPageState();
  }
}

class vrPageState extends State<Vrpage> {
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  List<Image> panoImages = [
    Image.asset('assets/vr/panorama.jpg'),
    Image.asset('assets/vr/panorama2.jpg'),
    Image.asset('assets/vr/panorama_cropped.webp'),
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon != null
            ? TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  backgroundColor: MaterialStateProperty.all(Colors.black38),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Icon(icon),
                onPressed: onPressed,
              )
            : GestureDetector(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                onTap: onPressed,
              ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text)),
              )
            : Container(),
      ],
    );
  }

  double dx = 100, dy = 100;

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    switch (_panoId % panoImages.length) {
      case 0:
        panorama = PanoramaViewer(
          animSpeed: 1.0,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          onTap: (longitude, latitude, tilt) =>
              print('onTap: $longitude, $latitude, $tilt'),
          onLongPressStart: (longitude, latitude, tilt) =>
              print('onLongPressStart: $longitude, $latitude, $tilt'),
          onLongPressMoveUpdate: (longitude, latitude, tilt) =>
              print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
          onLongPressEnd: (longitude, latitude, tilt) =>
              print('onLongPressEnd: $longitude, $latitude, $tilt'),
          child: panoImages[_panoId % panoImages.length],
          hotspots: [
            Hotspot(
              latitude: 2.010,
              longitude: -12.85,
              width: 90,
              height: 75,
              widget: hotspotButton(onPressed: () {
                _panoId++;
              }),
            ),
            Hotspot(
              latitude: -47.56,
              longitude: -53.11,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                  icon: Icons.phone_android,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/Pic"))),
            ),
          ],
        );
        break;
      case 2:
        panorama = GestureDetector(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          onDoubleTap: () {
            setState(() {
              _panoId = 0;
            });
          },
        );
        break;
      default:
        panorama = PanoramaViewer(
          animSpeed: 1.0,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          child: panoImages[_panoId % panoImages.length],
          hotspots: [
            Hotspot(
              latitude: 0.0,
              longitude: 160.0,
              width: 90.0,
              height: 75.0,
              widget: hotspotButton(
                  text: "Next scene",
                  icon: Icons.double_arrow,
                  onPressed: () => setState(() => _panoId++)),
            ),
          ],
        );
    }
    return Scaffold(
        body: Stack(
      children: [
        panorama,
        Padding(
          padding: EdgeInsets.only(left: 20, top: 50),
          child: Text(
            '${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ));
  }
}
