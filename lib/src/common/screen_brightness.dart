import 'package:screen_brightness/screen_brightness.dart';

Future<void> setMaximalScreenBrightness() async {
  try {
    await ScreenBrightness().setApplicationScreenBrightness(1.0);
  } catch (e) {
    throw 'Failed to set brightness';
  }
}

Future<void> resetScreenBrightness() async {
  try {
    final screenBrightness = ScreenBrightness();
    await screenBrightness.setApplicationScreenBrightness(await screenBrightness.system);
  } catch (e) {
    throw 'Failed to get system brightness';
  }
}
