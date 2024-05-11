// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PriceFilter extends StatefulWidget {
//   final double sliderValue;
//   final void Function(double) onSliderValueChanged;
//
//   const PriceFilter({
//     super.key,
//     required this.sliderValue,
//     required this.onSliderValueChanged,
//   });
//
//   @override
//   State<PriceFilter> createState() => _PriceFilterState();
// }
//
// class _PriceFilterState extends State<PriceFilter> {
//   bool isFreeSelected = false;
//   late double _currentValue;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentValue = widget.sliderValue;
//   }
//
//   _savePriceRange(double value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (isFreeSelected) {
//       await prefs.setDouble('priceRange', 0);
//       widget.onSliderValueChanged(0);
//     } else {
//       await prefs.setDouble('priceRange', value);
//       widget.onSliderValueChanged(value);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Free',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               Radio(
//                 value: true,
//                 groupValue: isFreeSelected,
//                 onChanged: (value) {
//                   setState(() {
//                     isFreeSelected = value!;
//                     if (isFreeSelected) {
//                       // If Free is selected, set the current value to 0 and save
//                       _currentValue = 0;
//                       _savePriceRange(0);
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Set price range',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               Radio(
//                 value: false,
//                 groupValue: isFreeSelected,
//                 onChanged: (value) {
//                   setState(() {
//                     isFreeSelected = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//           const Row(
//             children: [
//               Text(
//                 'Min : 0',
//                 style: TextStyle(),
//               ),
//               SizedBox(
//                 width: 15,
//               ),
//               Text(
//                 'Max : 3000',
//                 style: TextStyle(),
//               ),
//             ],
//           ),
//           Visibility(
//             visible: !isFreeSelected,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Price : ₹${_currentValue.toInt()}',
//                 ),
//                 const SizedBox(height: 10),
//                 SliderTheme(
//                   data: SliderThemeData(
//                     activeTrackColor: Colors.blue,
//                     inactiveTrackColor: Colors.blue.withOpacity(0.2),
//                     thumbColor: Colors.blue,
//                     thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
//                     overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
//                   ),
//                   child: Slider(
//                     value: _currentValue,
//                     min: 0,
//                     max: 3000,
//                     divisions: 3000 ~/ 500,
//                     onChanged: (double value) {
//                       setState(() {
//                         _currentValue = value;
//                         _savePriceRange(value);
//                       });
//                     },
//                     activeColor: Colors.blue,
//                     inactiveColor: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriceFilter extends StatefulWidget {
  final double sliderValue;
  final void Function(double) onSliderValueChanged;

  const PriceFilter({
    super.key,
    required this.sliderValue,
    required this.onSliderValueChanged,
  });

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  bool isFreeSelected = false;
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.sliderValue;
  }

  _savePriceRange(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isFreeSelected) {
      await prefs.setDouble('priceRange', 0);
      widget.onSliderValueChanged(0);
    } else {
      await prefs.setDouble('priceRange', value);
      widget.onSliderValueChanged(value);
    }
  }

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
                    if (isFreeSelected) {
                      // If Free is selected, set the current value to 0 and save
                      _currentValue = 0;
                      _savePriceRange(0);
                    }
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
                Text(
                  'Price : ₹${_currentValue.toInt()}',
                ),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.blue.withOpacity(0.2),
                    thumbColor: Colors.blue,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    value: _currentValue,
                    min: 0,
                    max: 3000,
                    divisions: 3000 ~/ 500,
                    onChanged: (double value) {
                      setState(() {
                        _currentValue = value;
                        _savePriceRange(value);
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
