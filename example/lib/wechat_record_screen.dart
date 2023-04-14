import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';

class WeChatRecordScreen extends StatefulWidget {
  const WeChatRecordScreen({Key? key}) : super(key: key);

  @override
  State<WeChatRecordScreen> createState() => _WeChatRecordScreenState();
}

class _WeChatRecordScreenState extends State<WeChatRecordScreen> {
  String toastShow = "悬浮框";
  OverlayEntry? overlayEntry;

  showView(BuildContext context) {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (content) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.5 - 80,
          left: MediaQuery.of(context).size.width * 0.5 - 80,
          child: Material(
            child: Center(
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xff77797A),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        toastShow,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  startRecord() {
    debugPrint("开始录制");
  }

  stopRecord(String path, double audioTimeLength) {
    debugPrint("结束束录制");
    debugPrint("音频文件位置$path");
    debugPrint("音频录制时长$audioTimeLength");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("仿微信发送语音"),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              showView(context);
            },
            child: const Text("悬浮组件"),
          ),
          TextButton(
            onPressed: () {
              if (overlayEntry != null) {
                overlayEntry?.remove();
                overlayEntry = null;
              }
            },
            child: const Text("隐藏悬浮组件"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                toastShow = "111";
                if (overlayEntry != null) {
                  overlayEntry?.markNeedsBuild();
                }
              });
            },
            child: const Text("悬浮窗状态更新"),
          ),
          VoiceWidget(
            onStartRecord: startRecord,
            onStopRecord: stopRecord,
            // 加入定制化Container的相关属性
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
