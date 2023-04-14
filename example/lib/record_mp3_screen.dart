import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import 'package:path_provider/path_provider.dart';

class RecordMp3Screen extends StatefulWidget {
  const RecordMp3Screen({Key? key}) : super(key: key);

  @override
  State<RecordMp3Screen> createState() => _RecordMp3ScreenState();
}

class _RecordMp3ScreenState extends State<RecordMp3Screen> {
  FlutterPluginRecord recordPlugin = FlutterPluginRecord();

  String filePath = "";

  @override
  void initState() {
    super.initState();

    ///初始化方法的监听
    recordPlugin.responseFromInit.listen((data) {
      if (data) {
        debugPrint("初始化成功");
      } else {
        debugPrint("初始化失败");
      }
    });

    /// 开始录制或结束录制的监听
    recordPlugin.response.listen((data) {
      if (data.msg == "onStop") {
        ///结束录制时会返回录制文件的地址方便上传服务器
        debugPrint("onStop  文件路径${data.path}");
        filePath = data.path!;
        debugPrint("onStop  时长 ${data.audioTimeLength}");
      } else if (data.msg == "onStart") {
        debugPrint("onStart --");
      } else {
        debugPrint("--${data.msg}");
      }
    });

    ///录制过程监听录制的声音的大小 方便做语音动画显示图片的样式
    recordPlugin.responseFromAmplitude.listen((data) {
      var voiceData = double.parse(data.msg ?? '');
      debugPrint("振幅大小   $voiceData");
    });

    recordPlugin.responsePlayStateController.listen((data) {
      debugPrint("播放路径   ${data.playPath}");
      debugPrint("播放状态   ${data.playState}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('录制mp3'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: const Text("初始化录制mp3"),
              onPressed: () {
                _initRecordMp3();
              },
            ),
            TextButton(
              child: const Text("开始录制"),
              onPressed: () {
                start();
              },
            ),
            TextButton(
              child: const Text("根据路径录制mp3文件"),
              onPressed: () {
                _requestAppDocumentsDirectory();
              },
            ),
            TextButton(
              child: const Text("停止录制"),
              onPressed: () {
                stop();
              },
            ),
            TextButton(
              child: const Text("播放"),
              onPressed: () {
                play();
              },
            ),
            TextButton(
              child: const Text("播放本地指定路径录音文件"),
              onPressed: () {
                playByPath(filePath, "file");
              },
            ),
            TextButton(
              child: const Text("播放网络mp3文件"),
              onPressed: () {
                playByPath(
                    "https://test-1259809289.cos.ap-nanjing.myqcloud.com/temp.mp3",
                    "url");
              },
            ),
            TextButton(
              child: const Text("暂停|继续播放"),
              onPressed: () {
                pause();
              },
            ),
            TextButton(
              child: const Text("停止播放"),
              onPressed: () {
                stopPlay();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _requestAppDocumentsDirectory() {
//    if(Platform.isIOS){
//      //ios相关代码
//      setState(() {
//        getApplicationDocumentsDirectory().then((value) {
//          String nowDataTimeStr = DateUtil.getNowDateMs().toString();
//          String wavPath = value.path + "/" + nowDataTimeStr + ".wav";
//          startByWavPath(wavPath);
//        });
//      });
//    }else if(Platform.isAndroid){
//      //android相关代码
//    }

    setState(() {
      getApplicationDocumentsDirectory().then((value) {
        String nowDataTimeStr =
            DateTime.now().millisecondsSinceEpoch.toString();
        // TODO  注意IOS 传递的Mp3路径一定是以 .MP3 结尾
        String wavPath = "";
        if (Platform.isIOS) {
          wavPath = "${value.path}/$nowDataTimeStr.MP3";
        } else {
          wavPath = "${value.path}/$nowDataTimeStr";
        }
        startByWavPath(wavPath);
      });
    });
  }

  ///初始化语音录制的方法
  void _initRecordMp3() async {
    recordPlugin.initRecordMp3();
  }

  ///开始语音录制的方法
  void start() async {
    recordPlugin.start();
  }

  ///根据传递的路径进行语音录制
  void startByWavPath(String wavPath) async {
    recordPlugin.startByWavPath(wavPath);
  }

  ///停止语音录制的方法
  void stop() {
    recordPlugin.stop();
  }

  ///播放语音的方法
  void play() {
    recordPlugin.play();
  }

  ///播放指定路径录音文件  url为iOS播放网络语音，file为播放本地语音文件
  void playByPath(String path, String type) {
    recordPlugin.playByPath(path, type);
  }

  ///暂停|继续播放
  void pause() {
    recordPlugin.pausePlay();
  }

  @override
  void dispose() {
    /// 当界面退出的时候是释放录音资源
    recordPlugin.dispose();
    super.dispose();
  }

  void stopPlay() {
    recordPlugin.stopPlay();
  }
}
