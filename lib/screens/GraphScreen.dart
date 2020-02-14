import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';
import 'package:lura_dentist_webapp/widgets/PHGraph.dart';
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

    return Stack(
      children: <Widget>[
        Visibility(
          visible: provider.loadingData,
          child: LoadingWidget("Loading graph", LURA_BLUE),
        ),
//        Visibility(
//          visible: !provider.loadingData,
//          child: PHGraph(provider),
//        )
      ],
    );
  }
}
