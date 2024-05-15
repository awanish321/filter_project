import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkExperienceFilter extends StatefulWidget {
  final double workExperienceRange;
  final void Function(double) onWorkExperienceChanged;

  const WorkExperienceFilter({
    super.key,
    required this.workExperienceRange,
    required this.onWorkExperienceChanged,
  });

  @override
  State<WorkExperienceFilter> createState() => _WorkExperienceFilterState();
}

class _WorkExperienceFilterState extends State<WorkExperienceFilter> {
  late double _workExperienceRange;

  @override
  void initState() {
    super.initState();
    _workExperienceRange = widget.workExperienceRange;
  }

  _loadWorkExperienceRange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _workExperienceRange = prefs.getDouble('workExperienceRange') ?? 4;
    });
  }

  _saveWorkExperienceRange(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('workExperienceRange', value);
    widget.onWorkExperienceChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Min : 4'),
              SizedBox(width: 16,),
              Text('Max : 30+'),
            ],
          ),
          Text('Experience : ${_workExperienceRange.round()} Year'),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.blue.withOpacity(0.3),
              thumbColor: Colors.blue,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Slider(
              value: _workExperienceRange,
              min: 4.0, // Set min value to 4
              max: 30.0,
              divisions: null,
              label: '${_workExperienceRange.round()}',
              onChanged: (value) {
                setState(() {
                  _workExperienceRange = value;
                  _saveWorkExperienceRange(value); // Save the value
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

