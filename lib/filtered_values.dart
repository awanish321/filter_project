import 'package:flutter/material.dart';
import 'home_screen.dart';

class FilteredDataScreen extends StatelessWidget {

  final Map<String, dynamic> selectedData;
  final List<String> selectedCategory;
  final List<String> selectedRole;
  final List<String> selectedSkills;
  final List<String> selectedCompanies;
  final List<String> selectedLocation;
  final double selectedPrice;
  final double selectedWorkExperience;
  final List<String> selectedLanguage;
  final List<String> selectedAvailableDays;

  const FilteredDataScreen({
    super.key,
    required this.selectedData,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedData.entries.map((entry) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
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
                                children: (entry.value as List<String>)
                                    .map((subcategory) => Text('• $subcategory'))
                                    .toList(),
                              )
                            else if (entry.key == 'Price')
                              Text('• ₹${selectedPrice.toInt()}')
                            else if (entry.key == 'Work Experience')
                                Text('• ${selectedWorkExperience.toStringAsFixed(0)} years')
                              else
                                Text('• ${entry.value}'),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryFilterScreen(
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
                  },
                  child: const Text("SUBMIT", style: TextStyle(color: Colors.black),),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
