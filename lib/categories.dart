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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Categories",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.0),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            SizedBox(height: 12.0),
            Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black54),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      height: 250,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        "https://picsum.photos/500/260",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            textAlign: TextAlign.left,
                            "Tech Gadgets",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            textAlign: TextAlign.left,
                            "Tech Gadgets",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                              minimumSize: Size(60, 60),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Row(
                              spacing: 5.0,
                              children: [
                                Text("Explore Category"),
                                Icon(CupertinoIcons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
