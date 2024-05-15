import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filter',
      theme: ThemeData(
          textTheme: GoogleFonts.notoMusicTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false
      ),
      home: const CategoryFilterScreen(selectedCategory: [],
        selectedRole: [],
        selectedSkills: [],
        selectedCompanies: [],
        selectedLocation: [],
        selectedPrice: 0,
        selectedWorkExperience: 4,
        selectedLanguage: [],
        selectedAvailableDays: [],
      ),
    );
  }
}