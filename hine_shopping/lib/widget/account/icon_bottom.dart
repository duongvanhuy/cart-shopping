import 'package:flutter/material.dart';

class IconBottom extends StatelessWidget {
  const IconBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 35,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.greenAccent,
              ),
              alignment: Alignment.center,
              child: Image(image: AssetImage('icon/google-logo.png')),
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.greenAccent,
              ),
              alignment: Alignment.center,
              child: Image(image: AssetImage('icon/facebook-new.png')),
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.greenAccent,
              ),
              alignment: Alignment.center,
              child: Image(image: AssetImage('icon/mac-os.png')),
            ),
          ),

          // icon google
        ],
      ),
    );
  }
}
