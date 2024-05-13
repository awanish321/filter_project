import 'package:flutter/material.dart';


class FilteredDataScreen extends StatelessWidget {
  final Map<String, dynamic> selectedData;
  final List<String> selectedCategory;
  final List<String> selectedRole;
  final List<String> selectedSkills;
  final List<String> selectedCompanies;
  final String selectedLocation;
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
      appBar: AppBar(
        title: const Text('Selected Filters'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: selectedData.entries.map((entry) {
            return Column(
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
                  Text('• ₹${entry.value}')
                else if (entry.key == 'Work Experience')
                    Text('• ${entry.value} years')
                  else
                    Text('• ${entry.value.toString()}'),
                const SizedBox(height: 10),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
