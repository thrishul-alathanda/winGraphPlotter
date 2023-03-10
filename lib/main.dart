import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:intl/intl.dart';    //not why i used this.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WinGraph',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Windows Graph'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GraphData> _chartData = [];
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: false);

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: SfCartesianChart(
        title: ChartTitle(text: 'Testing Data'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        //primaryYAxis: CategoryAxis(),
        series: <FastLineSeries>[
          FastLineSeries<GraphData, double>(
            name: 'Data',
            dataSource: _chartData,
            xValueMapper: (GraphData xAxisData, _) => xAxisData.time,
            yValueMapper: (GraphData yAxisData, _) => yAxisData.yAxixData,
            // ignore: prefer_const_constructors
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Colors.black,
            width: 3,
            opacity: 1,
            //cardinalSplineTension: 0.1  //This is used for SplineSeries;
          )
        ],
        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        //  primaryXAxis: CategoryAxis(title: AxisTitle(text: "Time")),
        //primaryYAxis: NumericAxis(numberFormat: NumberFormat.decimalPattern()),
      ),
    ));
  }

  List<GraphData> getChartData() {
    final List<GraphData> chartData = [
      // ignore: todo
      // TODO Read data from *.txt, parse and send it here

      GraphData(1.1, 0.5),
      GraphData(1.2, 0.7),
      GraphData(1.3, 1.3),
      GraphData(1.4, 0.2),
      GraphData(1.5, 1.8),
      GraphData(1.6, 1.7),
      GraphData(1.7, 1.8)
    ];
    return chartData;
  }
}

class GraphData {
  GraphData(this.time, this.yAxixData);
  final double time;
  final double yAxixData;
}
