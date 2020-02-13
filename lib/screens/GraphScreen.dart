import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:provider/provider.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GraphDataProvider(),
        child: GraphWidget(),

    );
  }
}

class GraphWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GraphDataProvider provider = Provider.of<GraphDataProvider>(context);
    provider.getData();

    return Container();
  }
}

