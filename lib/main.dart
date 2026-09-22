import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Sẽ báo đỏ cho đến khi làm Bước 3
void main() {
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 debugShowCheckedModeBanner: false,
 title: 'Task Manager',
 theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
 home: const HomeScreen(),
 );
 }
}