import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter/price.dart';
import 'package:filter/work_experience.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'filtered_values.dart';

class CategoryFilterScreen extends StatefulWidget {
  const CategoryFilterScreen({super.key});

  @override
  State<CategoryFilterScreen> createState() => _CategoryFilterScreenState();
}

class _CategoryFilterScreenState extends State<CategoryFilterScreen> {
  final List<String> categories = [
    'Category',
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
    'Category' : [],
    'Role': [],
    'Skills': [],
    'Companies': [],
    'Location': [],
    'Price': [],
    'Work Experience': [],
    'Language': [
      'English',
      'Hindi',
      'Bengali',
      'Telugu',
      'Marathi',
      'Tamil',
      'Gujarati',
      'Urdu',
      'Kannada',
      'Odia',
      'Punjabi',
    ],
    'Available Days': [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ]
  };

  List<String> filteredSubcategories = [];
  final TextEditingController _searchController = TextEditingController();
  Map<String, bool> categorySelections = {};
  Map<String, Map<String, bool>> selectedSubcategories = {};
  String currentCategory = '';
  bool isCategorySelected = false;
  double _currentPriceSliderValue = 0;
  double _currentWorkExperienceRange = 0;

  @override
  void initState() {
    super.initState();
    _showSubcategories(currentCategory);
    _fetchRolesFromFirestore();
    _fetchSkillsFromFirestore();
    // _fetchCompanyFromFirestore();
    _fetchLocationFromFirestore();
    _fetchCategoryFromFirestore();
    fetchCompanyData();

    // Initialize selectedSubcategories map
    for (var category in categories) {
      selectedSubcategories[category] = {};
      for (var subcategory in subcategories[category]!) {
        selectedSubcategories[category]![subcategory] = false;
      }
    }
  }


  Future<void> _fetchCategoryFromFirestore() async {
    try{
      final categoryCollection =
          await FirebaseFirestore.instance.collectionGroup('Category').get();
      final category = categoryCollection.docs.map((doc) => doc.get('name')).toList();
      setState(() {
        subcategories['Category'] =
            category.cast<String>();
      });
    }catch (e) {
      if(kDebugMode){
        print("Error fetching category from Firestore: $e");
      }
    }
  }


  Future<void> fetchCompanyData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Companies')
          .get();

      List<String> companies = [];

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? documentData =
        documentSnapshot.data() as Map<String, dynamic>?;
        if (documentData != null) {
          dynamic listData = documentData['company'] ?? [];
          if (listData is String) {
            companies.add(listData);
          } else if (listData is List<dynamic>) {
            for (Map<String, dynamic> mapData in listData) {
              String companyName = mapData['name'] ?? '';
              if (companyName.isNotEmpty) {
                companies.add(companyName);
              }
            }
          }
        }
      }

      setState(() {
        subcategories['Companies'] = companies;
      });
    } catch (e) {
      print('Error fetching companies from Firestore: $e');
    }
  }

  Future<void> _fetchRolesFromFirestore() async {
    try {
      final rolesCollection =
      await FirebaseFirestore.instance.collection('Role').get();
      final roles = rolesCollection.docs.map((doc) => doc.get('role')).toList();
      setState(() {
        subcategories['Role'] =
            roles.cast<String>();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching roles from Firestore: $e');
      }
    }
  }

  Future<void> _fetchSkillsFromFirestore() async {
    try {
      final skillCollection =
      await FirebaseFirestore.instance.collection('Skills').get();
      final skill =
      skillCollection.docs.map((doc) => doc.get('skill')).toList();
      setState(() {
        subcategories['Skills'] =
            skill.cast<String>();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching roles from Firestore: $e');
      }
    }
  }


  Future<void> _fetchLocationFromFirestore() async {
    try {
      final locationCollection =
      await FirebaseFirestore.instance.collection('Location').get();
      final location =
      locationCollection.docs.map((doc) => doc.get('location')).toList();
      setState(() {
        subcategories['Location'] =
            location.cast<String>();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching roles from Firestore: $e');
      }
    }
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      categorySelections.clear();
      for (var category in categories) {
        selectedSubcategories[category]!.updateAll((key, value) => false);
      }
      filteredSubcategories = [];
      _currentPriceSliderValue = 0;
      _currentWorkExperienceRange = 0;
    });
  }


  // void _clearSubcategories() {
  //   setState(() {
  //     _searchController.clear();
  //     if (currentCategory.isNotEmpty) {
  //       // Clear only selected subcategories of the current category
  //       selectedSubcategories[currentCategory]!
  //           .updateAll((key, value) => false);
  //     } else {
  //       // Clear all subcategory selections
  //       for (var category in categories) {
  //         selectedSubcategories[category]!.updateAll((key, value) => false);
  //       }
  //     }
  //   });
  // }

  void _clearSubcategories() {
    setState(() {
      _searchController.clear();
      if (currentCategory.isNotEmpty) {
        // Clear only selected subcategories of the current category
        selectedSubcategories[currentCategory]!.updateAll((key, value) => false);
      } else {
        // Clear all subcategory selections
        for (var category in categories) {
          selectedSubcategories[category]!.updateAll((key, value) => false);
        }
      }

      // Set price to zero if current category is "Price"
      if (currentCategory == "Price") {
        _currentPriceSliderValue = 0;
      }

      // Set work experience to zero if current category is "Work Experience"
      if (currentCategory == "Work Experience") {
        _currentWorkExperienceRange = 0;
      }
    });
  }



  void _showSubcategories(String category) {
    setState(() {
        if (subcategories.containsKey(category)) {
          filteredSubcategories = subcategories[category]!;
          // Use selectedSubcategories for the current category
          categorySelections = selectedSubcategories[category]!;
        } else {
          filteredSubcategories = [];
          categorySelections.clear();
        }
        isCategorySelected = true;
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



  void _applyFilter() {
    // Gather selected data for all categories
    Map<String, dynamic> selectedData = {};

    // Iterate through all categories
    for (var category in categories) {
      List<String> selectedSubcategoriesList = [];

      // Add selected subcategories for the current category
      selectedSubcategories[category]!.forEach((subcategory, isSelected) {
        if (isSelected) {
          selectedSubcategoriesList.add(subcategory);
        }
      });

      // Add selected subcategories to the map
      selectedData[category] = selectedSubcategoriesList;
    }

    // Add price value if applicable
    selectedData['Price'] = _currentPriceSliderValue;

    // Add work experience value if applicable
    selectedData['Work Experience'] = _currentWorkExperienceRange;

    // Navigate to another screen and pass the data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredDataScreen(selectedData: selectedData),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    _applyFilter();
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Apply Filter',
                          style: TextStyle(color: Colors.white)),
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
                  InkWell(
                    onTap: (){},
                    child: Image.asset(
                      "assets/x.png",
                      height: 14,
                      width: 14,
                    ),
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
                        ListView.separated(
                          separatorBuilder: (_, __) {
                        return const SizedBox();
                        },
                          physics: const BouncingScrollPhysics(),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                        if (currentCategory != "Work Experience" &&
                            currentCategory !=
                                "Price")
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterSubcategories('');
                                  },
                                )
                                    : null,
                                border: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal:
                                    16), // Adjust content padding here
                              ),
                              onChanged: _filterSubcategories,
                            ),
                          ),



                        if (currentCategory == "Work Experience" ||
                            currentCategory == "Price")
                          const Divider(),
                        Expanded(
                          child: currentCategory == "Work Experience"
                              ? WorkExperienceFilter(
                            workExperienceRange: _currentWorkExperienceRange,
                            onWorkExperienceChanged: (double value) {
                              setState(() {
                                _currentWorkExperienceRange = value;
                              });
                            },
                          )
                              : currentCategory == "Price"
                              ? PriceFilter(
                            sliderValue: _currentPriceSliderValue,
                            onSliderValueChanged: (double value) {
                              setState(() {
                                _currentPriceSliderValue = value;
                              });
                            },
                          )
                              : ListView.builder(
                            physics: const BouncingScrollPhysics(),
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

                                    autofocus: true,
                                    value: categorySelections[
                                    subcategory] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        categorySelections[
                                        subcategory] = value!;
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


