// import 'package:filter/price.dart';
// import 'package:filter/work_experience.dart';
// import 'package:flutter/material.dart';
//
// class CategoryFilterScreen extends StatefulWidget {
//   const CategoryFilterScreen({super.key});
//
//   @override
//   State<CategoryFilterScreen> createState() => _CategoryFilterScreenState();
// }
//
// class _CategoryFilterScreenState extends State<CategoryFilterScreen> {
//   final List<String> categories = [
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
//   Map<String, List<String>> subcategories = {
//     'Role': [
//       'Back End Developer',
//       'Full Stack Developer',
//       'Software Development - Other',
//       'Technical Lead',
//       'Data Warehouse Developer',
//       'Technical Architect',
//       'Database Administrator',
//       'ERP Developer',
//       'Blockchain Quality Assurance Engineer',
//       'System Administrator / Engineer',
//       'IT Support - Other',
//       'Mobile / App Developer',
//       'Engineering Manager',
//       'Head - Engineering',
//       'DevOps Engineer',
//       'Front End Developer',
//       'Network (Support) Engineer'
//     ],
//     'Skills': [
//       'Linux',
//       'C++',
//       'R',
//       'Data Engineering',
//       'Communication',
//       'CS',
//       'Data Science',
//       'Data Structures',
//       'Deep Learning',
//       'DevOps',
//       'Docker',
//       'Business Strategy',
//       'Consulting',
//       'Engineering Management',
//       'GATE Preparation',
//       'HTML',
//       'Kubernetes',
//       'Deep Learning',
//     ],
//     'Companies': [
//       'Abbott',
//       'ABES Engineering College',
//       'Accenture',
//       'Amazon',
//       'Asian Paints',
//       'Axtria',
//       'Bank of Baroda',
//       'Airtel',
//       'Birla Institute of Technology & Science',
//       'Cisco',
//       'Cognizant',
//       'Microsoft',
//     ],
//     'Location': [
//       'Bengaluru',
//       'Hyderabad',
//       'Pune',
//       'Delhi / NCR',
//       'Mumbai (All Areas)',
//       'Chennai',
//       'Gurugram',
//       'Kolkata',
//       'Lucknow'
//     ],
//     'Price': [],
//     'Work Experience': [],
//     'Language': [
//       'Arabic',
//       'Assamese',
//       'Bengali',
//     ],
//     'Available Days': [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday'
//     ]
//   };
//
//   List<String> filteredSubcategories = [];
//   final TextEditingController _searchController = TextEditingController();
//   Map<String, bool> categorySelections = {};
//   Map<String, bool> subcategorySelections = {};
//   String currentCategory = '';
//   bool isCategorySelected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     currentCategory = "Category";
//     _showSubcategories(currentCategory);
//   }
//
//
//   void _clearFilters() {
//     setState(() {
//       _searchController.clear();
//       categorySelections.clear();
//       for (var category in categories) {
//         categorySelections.addAll({
//           for (var subcategory in subcategories[category]!) subcategory: false
//         });
//       }
//       // currentCategory = '';
//       filteredSubcategories = [];
//     });
//   }
//
//   void _clearSubcategories() {
//     setState(() {
//       _searchController.clear();
//       if (currentCategory.isNotEmpty) {
//         // Clear only selected subcategories of the current category
//         for (var subcategory in subcategories[currentCategory]!) {
//           subcategorySelections[subcategory] = false;
//         }
//       } else {
//         // Clear all subcategory selections
//         subcategorySelections.clear();
//       }
//     });
//   }
//
//   Widget? widgetToShow;
//
//   void _showSubcategories(String category) {
//     setState(() {
//       if (category == "Category") {
//         // Clear filtered subcategories when "Category" is clicked
//         filteredSubcategories = [];
//         isCategorySelected = false;
//       } else if (category == "Work Experience") {
//         // Show the WorkExperienceFilter widget when "Work Experience" category is pressed
//         widgetToShow = WorkExperienceFilter();
//       } else {
//         // Show subcategories for the selected category
//         currentCategory = category;
//         if (subcategories.containsKey(category)) {
//           filteredSubcategories = subcategories[category]!;
//           // If category is selected, ensure subcategories remain selected
//           if (subcategorySelections.isNotEmpty) {
//             categorySelections = subcategorySelections;
//           } else {
//             categorySelections = {
//               for (var subcategory in subcategories[category]!) subcategory: false
//             };
//           }
//         } else {
//           filteredSubcategories = [];
//           categorySelections.clear();
//         }
//         isCategorySelected = true;
//       }
//     });
//   }
//
//
//   void _filterSubcategories(String query) {
//     setState(() {
//       filteredSubcategories = subcategories[currentCategory]!
//           .where((subcategory) =>
//           subcategory.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       persistentFooterButtons: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               onPressed: () {
//                 _clearFilters();
//                 _searchController.clear();
//                 _filterSubcategories('');
//               },
//               child: const Text(
//                 'Clear Filter',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//             const SizedBox(width: 15),
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50))),
//                   onPressed: () {
//                     // Handle apply filter button press
//                     final selectedSubcategories = categorySelections.entries
//                         .where((entry) => entry.value)
//                         .map((entry) => entry.key)
//                         .toList();
//                     debugPrint(
//                         'Selected Subcategories: $selectedSubcategories');
//                     // Save selected subcategories for current category
//                     subcategorySelections = categorySelections;
//                   },
//                   child: const Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Apply Filter', style: TextStyle(color: Colors.white)),
//                       SizedBox(width: 10),
//                       Icon(Icons.arrow_forward, color: Colors.white),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Text(
//                     'Filters',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const Spacer(),
//                   Image.asset(
//                     "assets/x.png",
//                     height: 14,
//                     width: 14,
//                   )
//                 ],
//               ),
//             ),
//             const Divider(),
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             _showSubcategories("Category");
//                             setState(() {
//                               currentCategory = "Category";
//                               isCategorySelected = true;
//                             });
//                           },
//                           child: ListTile(
//                             title: const Text("Category"),
//                             tileColor: currentCategory == "Category"
//                                 ? Colors.lightBlueAccent.withOpacity(0.1)
//                                 : null,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         ListView.separated(
//                           separatorBuilder: (_, __) {
//                             return const SizedBox();
//                           },
//                           shrinkWrap: true,
//                           itemCount: categories.length,
//                           itemBuilder: (context, index) {
//                             final category = categories[index];
//                             return ListTile(
//                               title: Text(
//                                 category,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                               onTap: () {
//                                 _showSubcategories(category);
//                                 setState(() {
//                                   currentCategory = category;
//                                   isCategorySelected = true;
//                                 });
//                               },
//                               tileColor: currentCategory == category
//                                   ? Colors.lightBlueAccent.withOpacity(0.1)
//                                   : null,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   VerticalDivider(color: Colors.grey.withOpacity(0.3)),
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               currentCategory.isNotEmpty
//                                   ? currentCategory
//                                   : 'Category',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // Handle clear button press
//                                 _clearSubcategories();
//                               },
//                               child: const Text(
//                                 'Clear',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         if (currentCategory != "Work Experience" && currentCategory != "Price") // Render search field except for "Work Experience" and "Price" categories
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: TextField(
//                               controller: _searchController,
//                               decoration: InputDecoration(
//                                 hintText: 'Search', // Move the hintText here
//                                 prefixIcon: const Icon(Icons.search),
//                                 suffixIcon: _searchController.text.isNotEmpty
//                                     ? IconButton(
//                                   icon: const Icon(Icons.clear),
//                                   onPressed: () {
//                                     _searchController.clear();
//                                   },
//                                 )
//                                     : null,
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust content padding here
//                               ),
//                               onChanged: _filterSubcategories,
//                             ),
//                           ),
//                         if (currentCategory == "Work Experience" || currentCategory == "Price")
//                           const Divider(thickness: 0.8,),
//                         Expanded(
//                           child: currentCategory == "Work Experience" ? WorkExperienceFilter() :
//                           currentCategory == "Price" ? PriceFilter() : ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: filteredSubcategories.length,
//                             itemBuilder: (context, index) {
//                               final subcategory =
//                               filteredSubcategories[index];
//                               return Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Checkbox(
//                                     value: categorySelections[subcategory] ??
//                                         false,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         categorySelections[subcategory] =
//                                         value!;
//                                       });
//                                     },
//                                   ),
//                                   Expanded(child: Text(subcategory)),
//                                 ],
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
//           ],
//         ),
//       ),
//
//
//
//     );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }
//




import 'package:flutter/material.dart';
import 'package:filter/price.dart';
import 'package:filter/work_experience.dart';


class CategoryFilterScreen extends StatefulWidget {
  const CategoryFilterScreen({Key? key}) : super(key: key);

  @override
  State<CategoryFilterScreen> createState() => _CategoryFilterScreenState();
}

class _CategoryFilterScreenState extends State<CategoryFilterScreen> {
  final List<String> categories = [
    'Role',
    'Skills',
    'Companies',
    'Location',
    'Price',
    'Work Experience',
    'Language',
    'Available Days'
  ];

    Map<String, List<String>> subcategories = {
    'Role': [
      'Back End Developer',
      'Full Stack Developer',
      'Software Development - Other',
      'Technical Lead',
      'Data Warehouse Developer',
      'Technical Architect',
      'Database Administrator',
      'ERP Developer',
      'Blockchain Quality Assurance Engineer',
      'System Administrator / Engineer',
      'IT Support - Other',
      'Mobile / App Developer',
      'Engineering Manager',
      'Head - Engineering',
      'DevOps Engineer',
      'Front End Developer',
      'Network (Support) Engineer'
    ],
    'Skills': [
      'Linux',
      'C++',
      'R',
      'Data Engineering',
      'Communication',
      'CS',
      'Data Science',
      'Data Structures',
      'Deep Learning',
      'DevOps',
      'Docker',
      'Business Strategy',
      'Consulting',
      'Engineering Management',
      'GATE Preparation',
      'HTML',
      'Kubernetes',
      'Deep Learning',
    ],
    'Companies': [
      'Abbott',
      'ABES Engineering College',
      'Accenture',
      'Amazon',
      'Asian Paints',
      'Axtria',
      'Bank of Baroda',
      'Airtel',
      'Birla Institute of Technology & Science',
      'Cisco',
      'Cognizant',
      'Microsoft',
    ],
    'Location': [
      'Bengaluru',
      'Hyderabad',
      'Pune',
      'Delhi / NCR',
      'Mumbai (All Areas)',
      'Chennai',
      'Gurugram',
      'Kolkata',
      'Lucknow'
    ],
    'Price': [],
    'Work Experience': [],
    'Language': [
      'Arabic',
      'Assamese',
      'Bengali',
    ],
    'Available Days': [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ]
  };

  List<String> filteredSubcategories = [];
  final TextEditingController _searchController = TextEditingController();
  Map<String, bool> categorySelections = {};
  Map<String, bool> subcategorySelections = {};
  String currentCategory = '';
  bool isCategorySelected = false;
  String selectedPriceRange = ''; // Track selected price range
  String selectedWorkExperience = ''; // Track selected work experience

  @override
  void initState() {
    super.initState();
    currentCategory = "Category";
    _showSubcategories(currentCategory);
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      categorySelections.clear();
      for (var category in categories) {
        categorySelections.addAll({
          for (var subcategory in subcategories[category]!) subcategory: false
        });
      }
      // currentCategory = '';
      filteredSubcategories = [];
    });
  }

  void _clearSubcategories() {
    setState(() {
      _searchController.clear();
      if (currentCategory.isNotEmpty) {
        // Clear only selected subcategories of the current category
        for (var subcategory in subcategories[currentCategory]!) {
          subcategorySelections[subcategory] = false;
        }
      } else {
        // Clear all subcategory selections
        subcategorySelections.clear();
      }
    });
  }

  void _applyFilters() {
    // Prepare data to pass to the next screen
    final selectedSubcategories = categorySelections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    // Pass selected price range and work experience to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredResultsScreen(
          selectedPriceRange: selectedPriceRange,
          selectedWorkExperience: selectedWorkExperience,
          selectedSubcategories: selectedSubcategories,
        ),
      ),
    );
  }

  void _showSubcategories(String category) {
    setState(() {
      if (category == "Category") {
        // Clear filtered subcategories when "Category" is clicked
        filteredSubcategories = [];
        isCategorySelected = false;
      } else if (category == "Work Experience") {
        // Show the WorkExperienceFilter widget when "Work Experience" category is pressed
        // Update selected work experience
        selectedWorkExperience = "Selected Work Experience";
      } else if (category == "Price") {
        // Show the PriceFilter widget when "Price" category is pressed
        // Update selected price range
        selectedPriceRange = "Selected Price Range";
      } else {
        // Show subcategories for the selected category
        currentCategory = category;
        if (subcategories.containsKey(category)) {
          filteredSubcategories = subcategories[category]!;
          // If category is selected, ensure subcategories remain selected
          if (subcategorySelections.isNotEmpty) {
            categorySelections = subcategorySelections;
          } else {
            categorySelections = {
              for (var subcategory in subcategories[category]!) subcategory: false
            };
          }
        } else {
          filteredSubcategories = [];
          categorySelections.clear();
        }
        isCategorySelected = true;
      }
    });
  }

  void _filterSubcategories(String query) {
    setState(() {
      filteredSubcategories = subcategories[currentCategory]!
          .where((subcategory) =>
          subcategory.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/x.png",
                    height: 14,
                    width: 14,
                  )
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _showSubcategories("Category");
                            setState(() {
                              currentCategory = "Category";
                              isCategorySelected = true;
                            });
                          },
                          child: ListTile(
                            title: const Text("Category"),
                            tileColor: currentCategory == "Category"
                                ? Colors.lightBlueAccent.withOpacity(0.1)
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ListView.separated(
                          separatorBuilder: (_, __) {
                            return const SizedBox();
                          },
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return ListTile(
                              title: Text(
                                category,
                                style: const TextStyle(fontSize: 14),
                              ),
                              onTap: () {
                                _showSubcategories(category);
                                setState(() {
                                  currentCategory = category;
                                  isCategorySelected = true;
                                });
                              },
                              tileColor: currentCategory == category
                                  ? Colors.lightBlueAccent.withOpacity(0.1)
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(color: Colors.grey.withOpacity(0.3)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentCategory.isNotEmpty
                                  ? currentCategory
                                  : 'Category',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle clear button press
                                _clearSubcategories();
                              },
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (currentCategory != "Work Experience" && currentCategory != "Price") // Render search field except for "Work Experience" and "Price" categories
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search', // Move the hintText here
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                )
                                    : null,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust content padding here
                              ),
                              onChanged: _filterSubcategories,
                            ),
                          ),
                        if (currentCategory == "Work Experience" || currentCategory == "Price")
                          const Divider(thickness: 0.8,),
                        Expanded(
                          child: currentCategory == "Work Experience"
                              ? WorkExperienceFilter()
                              : currentCategory == "Price"
                              ? PriceFilter()
                              : ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredSubcategories.length,
                            itemBuilder: (context, index) {
                              final subcategory =
                              filteredSubcategories[index];
                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: categorySelections[subcategory] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        categorySelections[subcategory] =
                                        value!;
                                      });
                                    },
                                  ),
                                  Expanded(child: Text(subcategory)),
                                ],
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
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                _clearFilters();
                _searchController.clear();
                _filterSubcategories('');
              },
              child: const Text(
                'Clear Filter',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: _applyFilters,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Apply Filter', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Create a new screen to display the filtered results
class FilteredResultsScreen extends StatelessWidget {
  final String selectedPriceRange;
  final String selectedWorkExperience;
  final List<String> selectedSubcategories;

  const FilteredResultsScreen({
    Key? key,
    required this.selectedPriceRange,
    required this.selectedWorkExperience,
    required this.selectedSubcategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Price Range: $selectedPriceRange'),
            Text('Selected Work Experience: $selectedWorkExperience'),
            Text('Selected Subcategories: $selectedSubcategories'),
            // Display other filtered results as needed
          ],
        ),
      ),
    );
  }
}
