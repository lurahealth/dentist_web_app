import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  final String loadingMessage;
  final Color colour;

  LoadingWidget(this.loadingMessage, this.colour);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Text(loadingMessage, style: TextStyle(color: colour),),
          )
        ],
      ),
    );
  }
}
