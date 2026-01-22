// import 'package:flutter/material.dart';
// import 'package:movie_booking/controller/booking_controller.dart';
// import 'package:movie_booking/controller/movie_controller.dart';
// import 'package:movie_booking/screens/splash_screen.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers:[ 
//         ChangeNotifierProvider(
//       create: (context) => MovieController(),
      
//          child: const MyApp()),
//          ChangeNotifierProvider(create: (context) => BookingController()),
//          ],
//     ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'movie', 
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: SplashScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_booking/controller/movie_controller.dart';
import 'package:movie_booking/controller/booking_controller.dart';  
import 'package:movie_booking/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieController()),
        ChangeNotifierProvider(create: (_) => BookingController()),  
      ],
      child: MaterialApp(
        title: 'Movie Explorer',
        debugShowCheckedModeBanner: false,  
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: SplashScreen(), 
      ),
    );
  }
}
