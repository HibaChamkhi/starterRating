import 'package:flutter/material.dart';
import 'feature/rating/presentation/page/rating_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RatingPage(),
    );
  }
}
