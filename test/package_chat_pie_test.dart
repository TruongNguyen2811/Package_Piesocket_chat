import 'package:flutter_test/flutter_test.dart';
import 'package:package_chat_pie/package_chat_pie.dart';
import 'package:package_chat_pie/package_chat_pie_platform_interface.dart';
import 'package:package_chat_pie/package_chat_pie_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPackageChatPiePlatform
    with MockPlatformInterfaceMixin
    implements PackageChatPiePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PackageChatPiePlatform initialPlatform = PackageChatPiePlatform.instance;

  test('$MethodChannelPackageChatPie is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPackageChatPie>());
  });

  test('getPlatformVersion', () async {
    PackageChatPie packageChatPiePlugin = PackageChatPie();
    MockPackageChatPiePlatform fakePlatform = MockPackageChatPiePlatform();
    PackageChatPiePlatform.instance = fakePlatform;

    expect(await packageChatPiePlugin.getPlatformVersion(), '42');
  });
}
