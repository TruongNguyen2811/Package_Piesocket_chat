import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class Utils {
  static bool isImageFile(String url) {
    String? mimeStr = lookupMimeType(url);
    final fileType = <String>[];
    fileType.addAll(mimeStr?.split('/') ?? []);
    if (fileType.isNotEmpty && fileType[0] == 'image') {
      return true;
    }
    return false;
  }

  static String formatMessageDate(String messageDate) {
    try {
      var date = DateTime.parse(messageDate);

      DateTime now = DateTime.now();
      Duration difference =
          now.difference(DateTime(date.year, date.month, date.day));

      if (difference.inDays == 0) {
        return "Hôm nay";
      } else if (difference.inDays == 1) {
        return "Hôm qua";
      } else {
        return DateFormat(
          "HH:mm, dd 'tháng' MM",
        ).format(date);
      }
    } catch (e) {
      return '';
    }
  }
}
