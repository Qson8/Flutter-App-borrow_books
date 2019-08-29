import 'package:ovprogresshud/progresshud.dart';

class HudUtil {
  static show() {
    dismiss();

    Progresshud.show();

    Future.delayed(Duration(milliseconds: 1000), () {
      dismiss();
    });
  }

  static dismiss() {
    Progresshud.dismiss();
  }

  static showSuccessStr(String message) {
     dismiss();

     Progresshud.showSuccessWithStatus(message);

     Future.delayed(Duration(milliseconds: 1000), () {
      dismiss();
    });
  }

  static showErrorStr(String message) {
     dismiss();

     Progresshud.showErrorWithStatus(message);

     Future.delayed(Duration(milliseconds: 1000), () {
      dismiss();
    });
  }
}
