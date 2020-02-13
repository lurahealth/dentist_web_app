class AreaChartData{
  double dataReading;
  DateTime timeStamp;

  AreaChartData(this.dataReading, this.timeStamp);

  factory AreaChartData.fromLiveData(DateTime timeStamp, double dataReading){
    return AreaChartData(dataReading, timeStamp);
  }

  factory AreaChartData.fromDatabase(int timeInMillSeconds, double dataReading){
    return AreaChartData(dataReading,
                      DateTime.fromMillisecondsSinceEpoch(timeInMillSeconds));
  }
}