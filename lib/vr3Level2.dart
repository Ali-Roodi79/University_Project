import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Vr3Level2page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return vr3Level2PageState();
  }
}

class vr3Level2PageState extends State<Vr3Level2page> {
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  List<Image> panoImages = [
    Image.asset('assets/vr/untitled4.jpg'),
    Image.asset('assets/vr/untitled2.jpg'),
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
                  width: 700,
                  height: 700,
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
          animSpeed: 0.1,
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
              longitude: -17.85,
              width: 90,
              height: 75,
              widget: hotspotButton(
                  text: "Next scene",
                  icon: Icons.open_in_browser_sharp,
                  onPressed: () {
                    _panoId++;
                  }),
            ),
            Hotspot(
              latitude: -1.56,
              longitude: -98.11,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                  icon: Icons.camera_alt,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/camera"))),
            ),
          ],
        );
        break;
      case 2:
        panorama = PanoramaViewer(
          animSpeed: 0.1,
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
              longitude: -17.85,
              width: 90,
              height: 75,
              widget: hotspotButton(
                  text: "Next scene",
                  icon: Icons.open_in_browser,
                  onPressed: () {
                    _panoId++;
                  }),
            ),
            Hotspot(
              latitude: -1.56,
              longitude: -98.11,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                  icon: Icons.camera_alt,
                  onPressed: () =>
                      setState(() => Navigator.pushNamed(context, "/Pic"))),
            ),
          ],
        );
        break;
      default:
        panorama = PanoramaViewer(
          animSpeed: 0.1,
          sensorControl: SensorControl.orientation,
          onViewChanged: onViewChanged,
          child: panoImages[_panoId % panoImages.length],
          hotspots: [
            Hotspot(
              latitude: 0.0,
              longitude: 115.0,
              width: 90.0,
              height: 75.0,
              widget: hotspotButton(
                  onPressed: () => setState(
                      () => Navigator.pushNamed(context, "/VR2Level2"))),
            ),
          ],
        );
    }
    return Scaffold(
      body: Stack(
        children: [
          panorama,
          //Padding(padding: EdgeInsets.only(left: 20,top:50),child: Text('${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}',style: TextStyle(color: Colors.white),),)
        ],
      ),
    );
  }
}
