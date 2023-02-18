import 'dart:io';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class GraphData {
  final double x;
  final double y;

  GraphData(this.x, this.y);
}

class _MyHomePageState extends State<MyHomePage> {
  List<GraphData> _chartData = [];

  Future<void> _loadData() async {
    try {
      final file = File('win_graph/src/data/data.txt');
      final contents = await file.readAsString();
      final lines = contents.trim().split('\n');

      final samplingRateLine = lines[0];
      final samplingRate = int.parse(samplingRateLine.split(':')[1].trim());

      final yAxisData = lines[1].split('\\').map(double.parse).toList();

      final xAxisData =
          List.generate(yAxisData.length, (i) => i / samplingRate);

      final data = List.generate(xAxisData.length, (i) {
        final x = xAxisData[i];
        final y = yAxisData[i];
        return GraphData(x, y);
      });

      setState(() {
        _chartData = data;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _chartData.isNotEmpty
          ? LineChart(
              [
                Series<GraphData, double>(
                  id: 'data',
                  colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                  domainFn: (data, _) => data.x,
                  measureFn: (data, _) => data.y,
                  data: _chartData,
                )
              ],
              animate: false,
              domainAxis: NumericAxisSpec(
                tickProviderSpec: StaticNumericTickProviderSpec(<TickSpec<num>>[
                  for (var i = 0; i < _chartData.length; i += 10)
                    TickSpec<num>(i.toDouble())
                ]),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Graph Demo'),
    );
  }
}
