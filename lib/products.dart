import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xAAE9F0FF),
        body: Column(
          children: [
            Row(
              children: [
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Text(
                                textAlign: TextAlign.left,
                                "50.0 ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              ElevatedButton(
                                onPressed: () => {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  minimumSize: Size(60, 60),
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Row(
                                  spacing: 5.0,
                                  children: [
                                    Text("Add"),
                                    Icon(CupertinoIcons.cart)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
