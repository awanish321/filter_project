import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter/price.dart';
import 'package:filter/work_experience.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'filtered_values.dart';

class CategoryFilterScreen extends StatefulWidget {
  const CategoryFilterScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedRole,
    required this.selectedSkills,
    required this.selectedCompanies,
    required this.selectedLocation,
    required this.selectedPrice,
    required this.selectedWorkExperience,
    required this.selectedLanguage,
    required this.selectedAvailableDays,
  });

  final List<String> selectedCategory;
  final List<String> selectedRole;
  final List<String> selectedSkills;
  final List<String> selectedCompanies;
  final List<String> selectedLocation;
  final double selectedPrice;
  final double selectedWorkExperience;
  final List<String> selectedLanguage;
  final List<String> selectedAvailableDays;

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
    'Category': [],
    'Role': [],
    'Skills': [],
    'Companies': [],
    'Location': [
      'Agra',
      'Ahmedabad',
      'Ajmer',
      'Akola',
      'Aligarh',
      'Allahabad',
      'Amritsar',
      'Asansol',
      'Aurangabad',
      'Bangalore',
      'Belgaum',
      'Bhiwandi',
      'Bhilai Nagar',
      'Bhopal',
      'Bhubaneswar',
      'Bikaner',
      'Chandigarh',
      'Chennai',
      'Cuttack',
      'Dehradun',
      'Delhi',
      'Dhanbad',
      'Faridabad',
      'Ghaziabad',
      'Gulbarga',
      'Guntur',
      'Gurgaon',
      'Guwahati',
      'Gwalior',
      'Howrah',
      'Hubli-Dharwad',
      'Hyderabad',
      'Indore',
      'Jabalpur',
      'Jaipur',
      'Jalandhar',
      'Jamnagar',
      'Jamshedpur',
      'Jodhpur',
      'Kalyan-Dombivli',
      'Kanpur',
      'Kochi',
      'Kolkata',
      'Kolhapur',
      'Kota',
      'Lucknow',
      'Ludhiana',
      'Madurai',
      'Mangalore',
      'Meerut',
      'Moradabad',
      'Mumbai',
      'Nagpur',
      'Nanded',
      'Nashik',
      'Nellore',
      'Noida',
      'Patna',
      'Pimpri-Chinchwad',
      'Pune',
      'Rajkot',
      'Ranchi',
      'Saharanpur',
      'Salem',
      'Sangli',
      'Siliguri',
      'Solapur',
      'Srinagar',
      'Surat',
      'Thane',
      'Thiruvananthapuram',
      'Tiruchirappalli',
      'Ulhasnagar',
      'Vadodara',
      'Varanasi',
      'Vasai-Virar',
      'Vellore',
      'Vijayawada',
      'Visakhapatnam',
      'Warangal'
    ],
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
  double _currentWorkExperienceRange = 4;
  List<String> selectedCategory = [];
  List<String> selectedRole = [];
  List<String> selectedSkills = [];
  List<String> selectedCompanies = [];
  List<String> selectedLocation = [];
  double selectedPrice = 0;
  double selectedWorkExperience = 0;
  List<String> selectedLanguage = [];
  List<String> selectedAvailableDays = [];


  @override
  void initState() {
    super.initState();

    selectedCategory = widget.selectedCategory;
    selectedRole = widget.selectedRole;
    selectedSkills = widget.selectedSkills;
    selectedCompanies = widget.selectedCompanies;
    selectedLocation = widget.selectedLocation;
    selectedPrice = widget.selectedPrice;
    selectedWorkExperience = widget.selectedWorkExperience;
    selectedLanguage = widget.selectedLanguage;
    selectedAvailableDays = widget.selectedAvailableDays;

    // Initialize selectedSubcategories after initializing the respective fields
    selectedSubcategories = {
      'Category': selectedCategory.asMap().map((key, value) => MapEntry(value, true)),
      'Role': selectedRole.asMap().map((key, value) => MapEntry(value, true)),
      'Skills': selectedSkills.asMap().map((key, value) => MapEntry(value, true)),
      'Companies': selectedCompanies.asMap().map((key, value) => MapEntry(value, true)),
      'Location': selectedLocation.asMap().map((key, value) => MapEntry(value, true)),
      'Language': selectedLanguage.asMap().map((key, value) => MapEntry(value, true)),
      'Available Days': selectedAvailableDays.asMap().map((key, value) => MapEntry(value, true)),
    };

    // Initialize the Price and Work Experience subcategories separately
    selectedSubcategories['Price'] = {
      selectedPrice.toString(): true,
    };
    selectedSubcategories['Work Experience'] = {
      selectedWorkExperience.toString(): true,
    };

    // Fetch data from Firestore
    _fetchCategoryFromFirestore().then((_) {
      // Call categoryFetch after fetching the category data
      categoryFetch();
    });
    _fetchRolesFromFirestore();
    _fetchSkillsFromFirestore();
    fetchCompanyData();
  }



  void categoryFetch() {
    // Initialize selections map for each category
    for (var category in categories) {
      if (!selectedSubcategories.containsKey(category)) {
        selectedSubcategories[category] = {};
      }
      for (var subcategory in subcategories[category]!) {
        if (!selectedSubcategories[category]!.containsKey(subcategory)) {
          selectedSubcategories[category]![subcategory] = false;
        }
      }
    }
    debugPrint("categories.first..$categories");

    // Show subcategories for the first category automatically
    _showSubcategories(categories.first);
    setState(() {
      currentCategory = categories[0];
      isCategorySelected = true;
    });
  }

  Future<void> _fetchCategoryFromFirestore() async {
    try {
      final categoryCollection =
          await FirebaseFirestore.instance.collectionGroup('Category').get();
      final category =
          categoryCollection.docs.map((doc) => doc.get('name')).toList();
      setState(() {
        subcategories['Category'] = category.cast<String>();
        _showSubcategories('Category');
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching category from Firestore: $e");
      }
    }
  }

  Future<void> fetchCompanyData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Companies').get();

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
      debugPrint('Error fetching companies from Firestore: $e');
    }
  }

  Future<void> _fetchRolesFromFirestore() async {
    try {
      final rolesCollection =
          await FirebaseFirestore.instance.collection('Role').get();
      final roles = rolesCollection.docs.map((doc) => doc.get('role')).toList();
      setState(() {
        subcategories['Role'] = roles.cast<String>();
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
        subcategories['Skills'] = skill.cast<String>();
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
      _currentWorkExperienceRange = 4;
    });
  }

  void _clearSubcategories() {
    setState(() {
      _searchController.clear();
      if (currentCategory.isNotEmpty) {
        // Clear only selected subcategories of the current category
        selectedSubcategories[currentCategory]!
            .updateAll((key, value) => false);
        categorySelections
            .clear(); // Clear categorySelections for the current category
      } else {
        // Clear all subcategory selections
        for (var category in categories) {
          selectedSubcategories[category]!.updateAll((key, value) => false);
        }
        categorySelections
            .clear(); // Clear categorySelections for all categories
      }

      // Set price to zero if current category is "Price"
      if (currentCategory == "Price") {
        _currentPriceSliderValue = 0;
      }

      // Set work experience to zero if current category is "Work Experience"
      if (currentCategory == "Work Experience") {
        _currentWorkExperienceRange = 4;
      }
    });
  }

  void _showSubcategories(String category) {
    setState(() {
      filteredSubcategories = subcategories[category]!;
      categorySelections = selectedSubcategories[category]!;
      isCategorySelected = true;
      currentCategory = category;
    });
    debugPrint("currentCategory...${filteredSubcategories.length}");
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
    selectedCategory = selectedSubcategories['Category']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedRole = selectedSubcategories['Role']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedSkills = selectedSubcategories['Skills']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedCompanies = selectedSubcategories['Companies']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedLanguage = selectedSubcategories['Language']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedAvailableDays = selectedSubcategories['Available Days']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    selectedLocation = selectedSubcategories['Location']!
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Set selected price
    selectedPrice = _currentPriceSliderValue;

    // Set selected work experience
    selectedWorkExperience = _currentWorkExperienceRange;

    // Pass selected data to the next screen
    Map<String, dynamic> selectedData = {
      'Category': selectedCategory,
      'Role': selectedRole,
      'Skills': selectedSkills,
      'Companies': selectedCompanies,
      'Location': selectedLocation,
      'Price': selectedPrice,
      'Work Experience': selectedWorkExperience,
      'Language': selectedLanguage,
      'Available Days': selectedAvailableDays,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredDataScreen(
          selectedData: selectedData,
          selectedCategory: selectedCategory,
          selectedRole: selectedRole,
          selectedSkills: selectedSkills,
          selectedCompanies: selectedCompanies,
          selectedLocation: selectedLocation,
          selectedPrice: selectedPrice,
          selectedWorkExperience: selectedWorkExperience,
          selectedLanguage: selectedLanguage,
          selectedAvailableDays: selectedAvailableDays,
        ),
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
                'Clear All Filters',
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
                      backgroundColor: Colors.yellow,
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
                          style: TextStyle(color: Colors.black)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.black),
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
                    onTap: () {},
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
                                log("category...$category");
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
                            currentCategory != "Price")
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
                                  workExperienceRange:
                                      _currentWorkExperienceRange,
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
                                        log("filteredSubcategories...${filteredSubcategories.length}");
                                        final subcategory =
                                            filteredSubcategories[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              hoverColor: Colors.yellow,
                                              tristate: true,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              value: categorySelections[
                                                      subcategory] ??
                                                  false,
                                              onChanged: (value) {
                                                setState(() {
                                                  categorySelections[
                                                          subcategory] =
                                                      value ?? false;
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
