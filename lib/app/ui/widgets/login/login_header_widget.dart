import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColorDark
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            color: Colors.black,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70),
        ),
      ),
      child: Image(
        image: AssetImage('lib/app/ui/assets/logo.png'),
      ),
    );
  }
}
