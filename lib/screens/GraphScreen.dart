import 'package:flutter/material.dart';
import 'package:lura_dentist_webapp/models/DisplayDataModel.dart';
import 'package:lura_dentist_webapp/models/patient/PatientModel.dart';
import 'package:lura_dentist_webapp/providers/GraphDataProvider.dart';
import 'package:lura_dentist_webapp/utils/StringUtils.dart';
import 'package:lura_dentist_webapp/utils/StyleUtils.dart';
import 'package:lura_dentist_webapp/widgets/LoadingWidget.dart';
import 'package:lura_dentist_webapp/widgets/PHGraph.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class GraphScreen extends StatelessWidget {
  final PatientModel currentPatient;

  GraphScreen(this.currentPatient);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GraphDataProvider(currentPatient),
      child: GraphWidget(),
    );
  }
}

class GraphWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GraphDataProvider provider = Provider.of<GraphDataProvider>(context);
    provider.getSensorDataFromCloud();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    DisplayDataModel currentSegment = DisplayDataModel();
    if (provider.displaySegments.length > 0) {
      currentSegment = provider.displaySegments[provider.currentSegment];
    }

    final segmentSelection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.arrow_back, color: LURA_ORANGE,), onPressed: provider.showLastWeeksData),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (currentSegment.startDate != null)?
                 Text(dateDisplayFormat.format(currentSegment.startDate),style: TextStyle(fontSize: 30))
                 : Text(""),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("to",style: TextStyle(fontSize: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (currentSegment.endDate != null)?
          Text(dateDisplayFormat.format(currentSegment.endDate), style: TextStyle(fontSize: 30))
          : Text(""),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.arrow_forward, color: LURA_ORANGE, ), onPressed: provider.showNextWeeksData),
        ),
      ],
    );

      return Scaffold(
        body: Stack(
          children: <Widget>[
            Visibility(
              visible: provider.loadingData,
              child: LoadingWidget("Loading data!", LURA_BLUE),
            ),
            Visibility(
                visible: !provider.loadingData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Card(
                                child: Container(
                                  width: width * 0.5,
                                  height: height * 0.13,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.arrow_back),
                                      Text("Patients",style: LURA_BLUE_TEXT.copyWith(fontSize: 20),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          dataCard("Average pH", currentSegment.averagePh,width * 0.5,height * 0.13),
                          dataCard("Highest pH", currentSegment.maxPh,width * 0.5,height * 0.13),
                          dataCard("Lowest pH", currentSegment.minPh,width * 0.5,height * 0.13),
                          dataCard("# Time pH above 5.5", currentSegment.timesOver,width * 0.5,height * 0.13),
                          dataCard("# Time pH below 5.5", currentSegment.timesUnder,width * 0.5,height * 0.13),
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              visible: provider.displaySegments.length > 2,
                                child: segmentSelection
                            ),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PHGraph(),
                            )),
                            Row(
                              children: <Widget>[
                                dataCard("Highest pH", currentSegment.maxPh,width *0.15,height*0.15),
                                dataCard("Lowest pH", currentSegment.minPh,width *0.15,height*0.15),
                                dataCard("# Time pH below 5.5", currentSegment.timesUnder,width *0.15,height*0.15),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Card(
                                      child: Container(
                                        width: width *0.15,
                                        height: height*0.15,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center ,
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
                                                  if (true/*picked != null*/ /*&& picked.length == 2*/) {
                                                    provider.sensorDataFromDate = picked[0];
                                                    provider.sensorDataToDate = picked[picked.length - 1];
                                                    provider.dataLoaded = false;
                                                    provider.getSensorDataFromCloud();
                                                  }
                                                },
                                                child: new Text("Pick date range")
                                            ),
                                            MaterialButton(
                                                onPressed: provider.clearDates,
                                                child: new Text("Clear Dates")
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                    ),
                  ],
                )
            )
          ],
        ),
      );
    }
  }


  Widget dataCard(String text, int number, double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(number.toString(), style: TextStyle(fontSize: 30)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text, style: LURA_BLUE_TEXT.copyWith(fontSize: 15),),
              )
            ],
          ),
        ),
      ),
    );
  }
