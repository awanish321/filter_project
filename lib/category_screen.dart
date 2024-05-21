
import 'package:flutter/material.dart';
import 'home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> buttonLabels = [
    'Role',
    'Skills',
    'Companies',
    'Location',
    'Price',
    'Work Experience',
    'Language',
    'Available Days'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (_, __) {
                              return const SizedBox(width: 10);
                            },
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: buttonLabels.length,
                            itemBuilder: (context, index) {
                              return RoundedButton(
                                label: buttonLabels[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String label;
  const RoundedButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: () {
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => CategoryFilterScreen(
             // selectedCategoryLabel: getCategory(label),
             selectedRole: [],
             selectedSkills: [],
             selectedCompanies: [],
             selectedLocation: [],
             selectedPrice: 0,
             selectedWorkExperience: 4,
             selectedLanguage: [],
             selectedAvailableDays: [], selectedCategory: getCategory(label),
           ),
         ),
       );
     },
      // selectedCategory: getCategory(label),

      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  String getCategory(String label) {
    switch (label) {
      case 'Role':
        return 'Role';
      case 'Skills':
        return 'Skills';
      case 'Companies':
        return 'Companies';
      case 'Location':
        return 'Location';
      case 'Price':
        return 'Price';
      case 'Work Experience':
        return 'Work Experience';
      case 'Language':
        return 'Language';
      case 'Available Days':
        return 'Available Days';
      default:
        return 'Category';
    }
  }
}



// import 'package:flutter/material.dart';
//
// import 'home_screen.dart';
//
// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }
//
// class _CategoryScreenState extends State<CategoryScreen> {
//   final List<String> buttonLabels = [
//     'Role',
//     'Skills',
//     'Companies',
//     'Location',
//     'Price',
//     'Work Experience',
//     'Language',
//     'Available Days'
//   ];
//
//   void navigateToCategoryFilterScreen(String selectedCategoryLabel) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryFilterScreen(
//           selectedCategoryLabel: selectedCategoryLabel,
//           selectedCategory: [],
//           selectedRole: [],
//           selectedSkills: [],
//           selectedCompanies: [],
//           selectedLocation: [],
//           selectedPrice: 0,
//           selectedWorkExperience: 4,
//           selectedLanguage: [],
//           selectedAvailableDays: [],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: Center(
//             child: SizedBox(
//               height: 45,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ListView.separated(
//                             separatorBuilder: (_, __) {
//                               return const SizedBox(width: 10);
//                             },
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             itemCount: buttonLabels.length,
//                             itemBuilder: (context, index) {
//                               return RoundedButton(
//                                 label: buttonLabels[index],
//                                 onTap: () {
//                                   navigateToCategoryFilterScreen(buttonLabels[index]);
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RoundedButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;
//
//   const RoundedButton({
//     Key? key,
//     required this.label,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 1.5),
//           borderRadius: BorderRadius.circular(50),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
