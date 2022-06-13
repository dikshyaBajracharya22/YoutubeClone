import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_clone/common/wrapper/multi_bloc_wrapper.dart';
import 'package:youtube_clone/common/wrapper/multi_repository_wrapper.dart';
import 'package:youtube_clone/features/splash/pages/splash_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return MultiRepositoryWrapper(
      child: MultiBlocWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Youtube Clone',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(textTheme),
            primarySwatch: Colors.blue,
          ),
          home:  SplashPages(),
          
        ),
      ),
    );
  }
}

