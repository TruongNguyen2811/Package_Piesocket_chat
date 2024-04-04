// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

// import 'package_chat_pie_platform_interface.dart';

// /// An implementation of [PackageChatPiePlatform] that uses method channels.
// class MethodChannelPackageChatPie extends PackageChatPiePlatform {
//   /// The method channel used to interact with the native platform.
//   @visibleForTesting
//   final methodChannel = const MethodChannel('package_chat_pie');

//   @override
//   Future<String?> getPlatformVersion() async {
//     final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
//     return version;
//   }
// }
