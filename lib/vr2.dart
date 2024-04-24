import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Vrpage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return vrPageState2();
  }
}

class vrPageState2 extends State<Vrpage2> {
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  List<Image> panoImages = [
    Image.asset('assets/vr2/panorama.jpg'),
    Image.asset('assets/vr2/panorama2.jpg'),
    Image.asset('assets/vr2/panorama_cropped.webp'),
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
              latitude: 0.510,
              longitude: -1.620,
              width: 90,
              height: 75,
              widget: hotspotButton(
                  text: "Computer",
                  icon: Icons.open_in_browser,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/windows"))),
            ),
            Hotspot(
              latitude: -1.510,
              longitude: 20.201,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                  icon: Icons.visibility,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/model"))),
            ),
            Hotspot(
              latitude: -8.510,
              longitude: -25.201,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                  icon: Icons.visibility,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/model2"))),
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
      ),
    );
  }
}
