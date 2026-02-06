import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0), // add padding around image
            child: Image.network(
              "https://i.pinimg.com/736x/1f/08/af/1f08afa9a13c89ee6a4c5cf441346da5.jpg",
              height: 400, // optional: control size
            ),
          ),
          SizedBox(height: 20,),
          Text("ROFLly" , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold))
        ],
      )),
    );
  }
}
