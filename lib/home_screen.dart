import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter/price.dart';
import 'package:filter/work_experience.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryFilterScreen extends StatefulWidget {
  const CategoryFilterScreen({super.key});

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
  double _currentValue = 0;
  double _workExperienceRange = 0.0;

  @override
  void initState() {
    super.initState();
    currentCategory = "Category";
    _showSubcategories(currentCategory);
    _fetchRolesFromFirestore();
    _fetchSkillsFromFirestore();
    _fetchCompanyFromFirestore();
    _fetchLocationFromFirestore();

    // Initialize selectedSubcategories map
    for (var category in categories) {
      selectedSubcategories[category] = {};
      for (var subcategory in subcategories[category]!) {
        selectedSubcategories[category]![subcategory] = false;
      }
    }
  }

  Future<void> _fetchCategoriesFromFirestore() async {
    try {
      final rolesCollection =
      await FirebaseFirestore.instance.collection('Categories').get();
      final roles = rolesCollection.docs.map((doc) => doc.get('name')).toList();
      setState(() {
        subcategories['Categories'] =
            roles.cast<String>(); // Update the 'Role' subcategories
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching roles from Firestore: $e');
      }
    }
  }

  Future<void> _fetchRolesFromFirestore() async {
    try {
      final rolesCollection =
      await FirebaseFirestore.instance.collection('Role').get();
      final roles = rolesCollection.docs.map((doc) => doc.get('role')).toList();
      setState(() {
        subcategories['Role'] =
            roles.cast<String>(); // Update the 'Role' subcategories
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
            skill.cast<String>(); // Update the 'Role' subcategories
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching roles from Firestore: $e');
      }
    }
  }

  Future<void> _fetchCompanyFromFirestore() async {
    try {
      final companyCollection =
      await FirebaseFirestore.instance.collection('Companies').get();
      final company =
      companyCollection.docs.map((doc) => doc.get('company')).toList();
      setState(() {
        subcategories['Companies'] =
            company.cast<String>();
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
    });
  }

  void _clearSubcategories() {
    setState(() {
      _searchController.clear();
      if (currentCategory.isNotEmpty) {
        // Clear only selected subcategories of the current category
        selectedSubcategories[currentCategory]!
            .updateAll((key, value) => false);
      } else {
        // Clear all subcategory selections
        for (var category in categories) {
          selectedSubcategories[category]!.updateAll((key, value) => false);
        }
      }
    });
  }

  void _showSubcategories(String category) {
    setState(() {
      if (category == "Category") {
        // Clear filtered subcategories when "Category" is clicked
        filteredSubcategories = [];
        isCategorySelected = false;
      } else {
        // Show subcategories for the selected category
        currentCategory = category;
        if (subcategories.containsKey(category)) {
          filteredSubcategories = subcategories[category]!;
          // Use selectedSubcategories for the current category
          categorySelections = selectedSubcategories[category]!;
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
                                "Price") // Render search field except for "Work Experience" and "Price" categories
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
                              ? const WorkExperienceFilter()
                              : currentCategory == "Price"
                              ? const PriceFilter()
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


