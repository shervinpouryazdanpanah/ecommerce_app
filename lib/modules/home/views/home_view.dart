import 'package:ecommerce/shared/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fake Store")),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
