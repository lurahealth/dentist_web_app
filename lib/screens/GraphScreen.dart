import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/providers/NewPatinetProvider.dart';
import 'package:lura_dentist_webapp/screens/NewPatinetDialog.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:lura_dentist_webapp/widgets/StatsWidget.dart';
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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Visibility(
            visible: provider.loadingData,
            child: LoadingWidget("Loading data!", LURA_BLUE),
          ),
          Visibility(
            visible: !provider.loadingData,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                        child: StatsWidget(provider)
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                          onPressed: () async {
                            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                                context: context,
                                initialFirstDate: new DateTime.now(),
                                initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                                firstDate: new DateTime(2015),
                                lastDate: new DateTime(2025)
                            );
                            if (picked != null && picked.length == 2) {
                              provider.sensorDataFromDate = picked[0];
                              provider.sensorDataToDate = picked[1];
                              provider.dataLoaded = false;
                              provider.getData();
                            }
                          },
                          child: new Text("Pick date range")
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
//        Visibility(
//          visible: !provider.loadingData,
//          child: PHGraph(provider),
//        )
        ],
      ),
    );
  }




}
