import 'package:flutter/material.dart';

class AppColor {
  static const white = Color(0xffffffff);
  static const grey = Color(0xfff1f1f1);
  static const greyLight = Color(0xffD1D1D1);
  static const black = Color(0xff000000);
  static const black222222 = Color(0xff222222);
  static const required = Color(0xffff3333);
  static const primary500 = Color(0xff00A651);
  static const primary400 = Color(0xff55D777);
  static const primary300 = Color(0xff90E5A6);
  static const primary200 = Color(0xffE6F9EB);
  static const neutral900 = Color(0xff141414);
  static const neutral800 = Color(0xff383838);
  static const neutral700 = Color(0xff595959);
  static const neutral500 = Color(0xff8C8C8C);
  static const neutral400 = Color(0xffBFBFBF);
  static const neutral300 = Color(0xffD9D9D9);
  static const neutral200 = Color(0xffe5e4e4);
  static const neutral100 = Color(0xffFAFAFA);
  static const darkRed2 = Color(0xFFAF376F);
  static const text = Color(0xFF374957);

  static const line = Color(0xffD6DEE5);
  static const Color brandColorMelon = Color(0xffb3d15f);
  static const Color brandColorYellow = Color(0xfff5c528);
  static const Color brandColorGreenPrimary = Color(0xff147a3f);
  static const Color brandColorGreenSecondary = Color(0xff5ab146);
  static const Color brandColorBackground = Color(0xffe2e478);
  static const Color primary700 = Color(0xff0f4c25);
  static const Color primary600 = Color(0xff1b9e55);
  static const Color primary100 = Color(0xfff5fff4);
  static const Color neutral0 = Color(0xffffffff);
  static const Color accent600 = Color(0xff2c6ecb);
  static const Color accent500 = Color(0xff3e8bff);
  static const Color accent200 = Color(0xffd0e2fb);
  static const Color accent100 = Color(0xfff2f7fe);
  static const Color secmanticG500 = Color(0xff52bd94);
  static const Color secmanticG100 = Color(0xfff5fbf8);
  static const Color secmanticY500 = Color(0xfffda33a);
  static const Color secmanticY200 = Color(0xffffe1aa);
  static const Color secmanticY100 = Color(0xfffffaf1);
  static const Color secmanticR500 = Color(0xffff3333);
  static const Color secmanticR100 = Color(0xfffdf4f4);
  static const Color secmanticC500 = Color(0xff25cbd6);
  static const Color secmanticC100 = Color(0xfff2fcfd);
  static const Color secmanticY700 = Color(0xffdb8e00);
  static const Color secmanticG700 = Color(0xff288e67);
  static const Color secmanticR200 = Color(0xffffcccc);
  static const Color secmanticR400 = Color(0xffff5757);
  static const Color secmanticY0 = Color(0xfffff9ed);
  static const List<Color> supportOverlayButton = <Color>[
    Color(0x00ffffff),
    Color(0xffffffff),
  ];
  static const Color supportOverlay = Color(0x80141414);

  static const Color loginBg = Color(0xFFF5F5E7);

  static const Color statusWaiting = Color(0xffFFF2D9);
  static const Color check = Color(0xff1ecf76);

  static const danger1 = Color(0xFFED1F42);
  static const dark12 = Color(0xFFE6E6E3);
  static const dark9 = Color(0xFFAFB1AF);
  static const dark1 = Color(0xFF0A0B09);
  static const dark5 = Color(0xFF6B6D6C);
  static const textDark = Color(0xFF6B6D6C);
  static const lightGray = Color(0xFF8F8F8F);
  static const darkRed = Color(0xFFCF2A2A);
  static const gray = Color(0xFF7E7E82);
  static const textSecondary = Color(0xFF626F82);
  static const otherBackground = Color(0xFFF3F4F5);
  static const yellow = Color(0xFFF5C528);
  static const orange = Color(0xFFFDA33A);
  static const blue = Color(0xFF2C6ECB);
  static const neutralDark60 = Color(0xFF7A7A7A);

  static const yellowLight = Color(0xFFFDD57C);
  static const yellowDark = Color(0xFFFDC540);

  static const loyaltyBg = Color(0xFFFBEDEF);
  static const loyaltyText = Color(0xFFA41C30);

  static const onboardingBg = Color(0xFF00A551);

  static const secmantic200 = Color(0xfffff1d7);
  static const secmantic500 = Color(0xFFFDA33A);
  static const textGrey = Color(0xFFF858787);
  static LinearGradient yellowLinear() {
    return const LinearGradient(colors: [yellowLight, yellowDark]);
  }

  static const secmanticy500 = Color(0xffFB8903);

  static const kLinearColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primary500,
      primary500,
    ],
    stops: [0.1119, 0.8481],
    // transform: GradientRotation(
    //     339 * 3.14 / 180), // Convert the angle from degrees to radians
  );

  static const primaryP700 = Color(0xff00361B);
  static const primaryP600 = Color(0xff006543);
  static const primaryP500 = Color(0xff00A651);
  static const primaryP400 = Color(0xff02E570);
  static const primaryP300 = Color(0xff46F99D);
  static const primaryP200 = Color(0xffE6F9EB);
  static const primaryP100 = Color(0xffEDFFF5);

  static const secondaryOrange = Color(0xffFC6F14);
  static const secondaryMelon = Color(0xff8BC53F);

  static const neutralN900 = Color(0xff1A1A1A);
  static const neutralN800 = Color(0xff383838);
  static const neutralN700 = Color(0xff555555);
  static const neutralN600 = Color(0xff8C8C8C);
  static const neutralN500 = Color(0xffBFBFBF);
  static const neutralN400 = Color(0xffD9D9D9);
  static const neutralN300 = Color(0xffE5E4E4);
  static const neutralN200 = Color(0xffF3F3F3);
  static const neutralN0 = Color(0xffffffff);

  static const successDefault = Color(0xff05B555);
  static const successSub = Color(0xffDFF6E4);
  static const warningDefault = Color(0xffFB9F21);
  static const warningSub = Color(0xffFFF6E9);
  static const errorDefault = Color(0xffEC3A39);
  static const errorSub = Color(0xffFEF1F1);
  static const informationDefault = Color(0xff10B7DB);
  static const informationSub = Color(0xffEEFCFF);

  static Color overlay = Color(0xff141414).withOpacity(0.5);
  static const background = Color(0xffF6F6F6);
  static const shadow = Color(0xff000000);

  static const gradientG1 = LinearGradient(
    colors: [
      Color(0xff8DC63F),
      Color(0xff00A651),
    ],
  );
  static const gradientG2 = LinearGradient(
    colors: [
      Color(0xffFC6F14),
      Color(0xffFFA345),
    ],
  );

  static const darkText = Color(0xff4E4E4E);
}
