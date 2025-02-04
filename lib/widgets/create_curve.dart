import 'package:flutter/material.dart';

class CreateCurve extends StatefulWidget {
  const CreateCurve({super.key});

  @override
  State<CreateCurve> createState() => _CreateCurveState();
}

class _CreateCurveState extends State<CreateCurve> {
  //
  List<Offset> _points = [];
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            //

            for (final offset in _points)
              Positioned(
                top: offset.dx,
                left: offset.dy,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
        },
        child: Icon(Icons.add),
      ),
    );
  }
  //
}

class CurvePainter extends CustomPainter {
  //
  @override
  void paint(Canvas canvas, Size size) {
    //
    //
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) {
    return true;
  }
  //
}
