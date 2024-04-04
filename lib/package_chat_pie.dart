
import 'package_chat_pie_platform_interface.dart';

class PackageChatPie {
  Future<String?> getPlatformVersion() {
    return PackageChatPiePlatform.instance.getPlatformVersion();
  }
}
