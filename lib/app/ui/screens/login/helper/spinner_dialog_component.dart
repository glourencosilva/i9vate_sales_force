import 'package:flutter/material.dart';

Future showLoadingDialogWidget(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    child: SimpleDialog(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Aguarde...',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ],
    ),
  );
}

void rideLoadingWidget(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
