import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}


class _ChartState extends State<Chart> {
   List<GDPData> chartData=getChartData();

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      isTransposed: true,
      series: <ChartSeries>[
        BarSeries<GDPData, String>(
          dataSource: chartData,
          xValueMapper: (GDPData gdp, _) => gdp.continent,
          yValueMapper: (GDPData gdp, _) => gdp.gdp,
        )
      ],
          primaryXAxis: CategoryAxis(),
    );
  }
}

List<GDPData> getChartData(){
  final List<GDPData> chartData=[
    GDPData("Student Users", 50),
    GDPData("Staff Users", 200),
  ];
  return chartData;
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String  continent;
  final  double gdp;
}