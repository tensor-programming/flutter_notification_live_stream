// import 'dart:isolate';
// import 'dart:ui';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:android_alarm_manager/android_alarm_manager.dart';

// import 'package:http/http.dart' as http;

// const String portname = "portname";

// void main() async {
//   await AndroidAlarmManager.initialize();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification/Alarm Example'),
//       ),
//       body: Center(
//         child: AlarmWidget(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.alarm),
//         onPressed: () async {
//           await AndroidAlarmManager.periodic(
//               Duration(seconds: 10), 0, isolateFunction);
//         },
//       ),
//     );
//   }
// }

// Future isolateFunction() async {
//   SendPort sendPort = IsolateNameServer.lookupPortByName(portname);
//   Repository repo = Repository();
//   String json = await repo.callApi();
//   sendPort?.send(json);
// }

// class AlarmWidget extends StatefulWidget {
//   @override
//   _AlarmWidgetState createState() => _AlarmWidgetState();
// }

// class _AlarmWidgetState extends State<AlarmWidget> {
//   ReceivePort port = ReceivePort();
//   List planets = [];

//   @override
//   void initState() {
//     super.initState();
//     initIsolate();
//   }

//   initIsolate() {
//     if (!IsolateNameServer.registerPortWithName(port.sendPort, portname)) {
//       throw 'Unable to name port';
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     IsolateNameServer.removePortNameMapping(portname);
//   }

//   createPlanets(String message) {
//     var jmap = json.decode(message);
//     planets.addAll(jmap["results"]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: StreamBuilder<String>(
//         stream: port.cast<String>(),
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           createPlanets(snapshot.data);

//           return ListView(
//             children: planets
//                 .map((planet) => ListTile(
//                       title: Text(planet['name']),
//                       subtitle: Text(planet['population']),
//                     ))
//                 .toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class Repository {
//   static const url = "https://swapi.co/api/planets/?format=json";

//   Future<String> callApi() async {
//     return await http.get(Uri.parse(url)).then((res) => res.body);
//   }
// }
