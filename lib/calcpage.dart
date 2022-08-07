import 'package:flutter/material.dart';

class calcPage extends StatefulWidget {
  const calcPage({Key? key}) : super(key: key);

  @override
  State<calcPage> createState() => _calcPageState();
}

class _calcPageState extends State<calcPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    var stateVal = data['stateVal'];
    var inputVal = data['inputVal'];

    return Scaffold(
      appBar: AppBar(title: Text('Calculate Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('INPUT ENTERED:', style: TextStyle(fontSize: 24)),
          Text(inputVal.toString(), style: TextStyle(fontSize: 22)),
          Text('CURRENT VALUE:', style: TextStyle(fontSize: 24)),
          Text(stateVal.toString(), style: TextStyle(fontSize: 20)),
          Text('RESULTS:'),
        ],
      ),
    );
  }
}
