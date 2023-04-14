import 'package:flutter/material.dart';

import 'path_provider_screen.dart';
import 'record_mp3_screen.dart';
import 'record_screen.dart';
import 'wechat_record_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "RecordScreen": (BuildContext context) => const RecordScreen(),
        "RecordMp3Screen": (BuildContext context) => const RecordMp3Screen(),
        "WeChatRecordScreen": (BuildContext context) =>
            const WeChatRecordScreen(),
        "PathProviderScreen": (BuildContext context) =>
            const PathProviderScreen(title: ''),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter版微信语音录制实现"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed<dynamic>(context, "RecordScreen");
              },
              child: const Text("进入语音录制界面"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed<dynamic>(context, "RecordMp3Screen");
              },
              child: const Text("进入录制mp3模式"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed<dynamic>(context, "WeChatRecordScreen");
              },
              child: const Text("进入仿微信录制界面"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed<dynamic>(context, "PathProviderScreen");
              },
              child: const Text("进入文件路径获取界面"),
            ),
          ],
        ),
      ),
    );
  }
}
