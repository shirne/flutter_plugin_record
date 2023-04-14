import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/custom_overlay.dart';

class CommonToast {
  static showView({
    BuildContext? context,
    String? msg,
    TextStyle? style,
    Widget? icon,
    Duration duration = const Duration(seconds: 1),
    int count = 3,
    Function? onTap,
  }) {
    OverlayEntry? overlayEntry;
    int innerCounter = 0;

    void removeOverlay() {
      overlayEntry?.remove();
      overlayEntry = null;
    }

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (content) {
        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              removeOverlay();
              onTap();
            }
          },
          child: CustomOverlay(
            icon: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: icon,
                ),
                Text(
                  msg ?? '',
                  style: style ??
                      const TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                )
              ],
            ),
          ),
        );
      });
      Overlay.of(context!).insert(overlayEntry!);
      if (onTap != null) return;
      Timer.periodic(duration, (timer) {
        innerCounter++;
        if (innerCounter == count) {
          innerCounter = 0;
          timer.cancel();
          removeOverlay();
        }
      });
    }
  }
}
