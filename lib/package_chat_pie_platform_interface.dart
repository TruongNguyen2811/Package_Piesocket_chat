import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package_chat_pie_method_channel.dart';

abstract class PackageChatPiePlatform extends PlatformInterface {
  /// Constructs a PackageChatPiePlatform.
  PackageChatPiePlatform() : super(token: _token);

  static final Object _token = Object();

  static PackageChatPiePlatform _instance = MethodChannelPackageChatPie();

  /// The default instance of [PackageChatPiePlatform] to use.
  ///
  /// Defaults to [MethodChannelPackageChatPie].
  static PackageChatPiePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PackageChatPiePlatform] when
  /// they register themselves.
  static set instance(PackageChatPiePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
