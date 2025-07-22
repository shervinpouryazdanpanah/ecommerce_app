import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xAAE9F0FF),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Categories",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 10.0, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
