import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';

class StatsWidget extends StatelessWidget {

  final GraphDataProvider provider;

  StatsWidget(this.provider);

  @override
  Widget build(BuildContext context) {

    final title = new Text(
      "ph Stats",
      style: TextStyle(
          color: LURA_BLUE,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: title,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: dataWidget("Lowest pH", provider.minPh),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: dataWidget("Highest pH", provider.maxPh),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: dataWidget("Average pH", provider.averagePh),
        )
      ],
    );
  }

  Widget dataWidget(String text, int values){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          SizedBox(width: 20,),
          Text(values.toString())
        ],
      ),
    );
  }
}
