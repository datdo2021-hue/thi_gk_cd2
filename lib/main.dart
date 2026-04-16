import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/news_provider.dart';
import 'presentation/screens/main_screen.dart'; // Import MainScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider()..loadFavorites(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}