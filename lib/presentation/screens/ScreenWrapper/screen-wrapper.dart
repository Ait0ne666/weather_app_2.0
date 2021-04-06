import 'package:flutter/material.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';

class ScreenWrapper extends StatelessWidget {
  final List<Widget> children;
  final Widget fab;

  ScreenWrapper({this.children, this.fab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab,
      body: Stack(children: [
        Sky(
          gradientColors: [
            Color(0xff631961),
            Color(0xffE94057),
            Color(0xffF27121)
          ],
        ),
        ...children
      ]),
    );
  }
}

// Color(0xff631961),
// Color(0xffE94057),
// Color(0xffF27121)

// Color(0xff182848),
// Color(0xff182848),
// Color(0xff3d5896)

// Color(0xffffe598),
// Color(0xff6190E8),
// Color(0xffA7BFE8),
