import 'package:flutter/material.dart';

enum TypeSlider { percent, number }

class SliderSelectWidget extends StatefulWidget {
  final Function(double value) onChanged;
  final String title;
  final TypeSlider type;
  SliderSelectWidget(
      {Key key, this.onChanged, this.title, this.type = TypeSlider.number})
      : super(key: key);

  @override
  _SliderSelectWidgetState createState() => _SliderSelectWidgetState();
}

class _SliderSelectWidgetState extends State<SliderSelectWidget> {
  double current = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.title, style: TextStyle(fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                      widget.type == TypeSlider.percent
                          ? current.toStringAsFixed(0) + " %"
                          : current.toStringAsFixed(0),
                      style: TextStyle(fontSize: 30, color: Colors.purple)),
                ),
              ],
            ),
            Slider(
              max: widget.type == TypeSlider.percent ? 100 : 250,
              min: 0,
              onChanged: (value) {
                setState(() {
                  current = value;
                });
                widget.onChanged(double.parse(value.toStringAsFixed(0)));
              },
              value: current,
            )
          ],
        ),
      ),
    );
  }
}
