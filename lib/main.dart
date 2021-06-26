import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milk_register/screens/home.dart';
import 'package:milk_register/screens/selector.dart';
import 'package:provider/provider.dart';
import 'package:background_fetch/background_fetch.dart';
 const platformMethodChannel =
const MethodChannel('heartbeat.fritz.ai/native');



/*void backgroundFetchHeadlessTask(HeadlessTask task) async {

  print('[BackgroundFetch] Headless event received.');
  String taskId = task.taskId;
  final String result =
  await platformMethodChannel.invokeMethod("notify3");
  String h=DateTime.now().hour.toString();
  String m=DateTime.now(). minute.toString();
  if(int.parse(h)>18)
    {


    }

  print(result);
  BackgroundFetch.finish(taskId);

} */

void main() {
  runApp(MyApp());
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState()async
  { final String result = await platformMethodChannel.invokeMethod("notify");
  print(result);}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        initialRoute: 'home',
        routes: {
          'home': (context) => Home(),
          'select': (context) => SelectMilk()

        }
    );
  }
}
