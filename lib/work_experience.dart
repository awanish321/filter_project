import 'package:flutter/material.dart';

class WorkExperienceFilter extends StatefulWidget {
  const WorkExperienceFilter({super.key});

  @override
  State<WorkExperienceFilter> createState() => _WorkExperienceFilterState();
}

class _WorkExperienceFilterState extends State<WorkExperienceFilter> {
  double _workExperienceRange = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Min : 0'),
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
              max: 30.0,
              divisions: null,
              label: '${_workExperienceRange.round()}',
              onChanged: (value) {
                setState(() {
                  _workExperienceRange = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
