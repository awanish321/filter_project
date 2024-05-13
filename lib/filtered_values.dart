// import 'package:flutter/material.dart';
// class FilteredDataScreen extends StatelessWidget {
//
//   final Map<String, dynamic> selectedData;
//   const FilteredDataScreen({super.key, required this.selectedData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Selected Filters'),),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display selected data for each category
//               for (var entry in selectedData.entries)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       entry.key,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     if (entry.value is List<String>)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           for (var subcategory in entry.value)
//                             Text('• $subcategory'),
//                         ],
//                       )
//                     else if (entry.value is double && entry.key == 'Price')
//                       Text('• ₹${entry.value.toStringAsFixed(1)}')
//                     else if (entry.value is double && entry.key == 'Work Experience')
//                         Text('• ${entry.value.toStringAsFixed(0)} years')
//                       else
//                         Text('• ${entry.value.toString()}'),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FilteredDataScreen extends StatelessWidget {
  final Map<String, dynamic> selectedData;

  const FilteredDataScreen({super.key, required this.selectedData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Filters'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var entry in selectedData.entries)
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          if (entry.value is List<String>)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var subcategory in entry.value)
                                  Text('• $subcategory'),
                              ],
                            )
                          else if (entry.value is double && entry.key == 'Price')
                            Text('• ₹${entry.value.toStringAsFixed(1)}')
                          else if (entry.value is double && entry.key == 'Work Experience')
                              Text('• ${entry.value.toStringAsFixed(1)} years')
                            else
                              Text('• ${entry.value.toString()}'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
