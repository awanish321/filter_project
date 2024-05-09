import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
  @override
  _PriceFilterState createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  bool isFreeSelected = false;
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Free',
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: true,
                groupValue: isFreeSelected,
                onChanged: (value) {
                  setState(() {
                    isFreeSelected = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Set price range',
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: false,
                groupValue: isFreeSelected,
                onChanged: (value) {
                  setState(() {
                    isFreeSelected = value!;
                  });
                },
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                'Min : 0',
                style: TextStyle(),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Max : 3000',
                style: TextStyle(),
              ),
            ],
          ),
          Visibility(
            visible: !isFreeSelected,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: _currentValue,
                  min: 0,
                  max: 3000,
                  onChanged: (double value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

