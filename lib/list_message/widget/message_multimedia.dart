import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:package_chat_pie/ultils/app_color.dart';
import 'package:package_chat_pie/ultils/utils.dart';
import 'package:package_chat_pie/widget/photo_gridview.dart';
import 'package:package_chat_pie/widget/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum MediaGridviewType { row, grid }

class MediaGridview extends StatelessWidget {
  const MediaGridview({
    super.key,
    required this.mediaURLs,
    this.type = MediaGridviewType.grid,
    this.width,
    this.onRemoveItem,
    this.isPadding = false,
  });
  final List<dynamic> mediaURLs;
  final MediaGridviewType? type;
  final double? width;
  final Function(int index)? onRemoveItem;
  final bool? isPadding;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: type == MediaGridviewType.grid
          ? buildGridLayout(width ?? MediaQuery.sizeOf(context).width)
          : buildRowLayout(width ?? MediaQuery.sizeOf(context).width, context),
    );
  }

  Widget buildRowLayout(double screenWidth, BuildContext context) {
    final sum = mediaURLs.length;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (isPadding == false) const SizedBox(width: 16),
          for (var i = 0; i < sum; i++)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PhotoPreviewScreen(url: mediaURLs[i])));
                },
                child: SizedBox(
                  height: (screenWidth - 32) / 5 - 8,
                  width: (screenWidth - 32) / 5 - 8,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.neutral200,
                          border:
                              Border.all(color: AppColor.neutral200, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: SizedBox(
                            height: (screenWidth - 32) / 5 - 8,
                            width: (screenWidth - 32) / 5 - 8,
                            child: Utils.isImageFile(mediaURLs[i])
                                ? mediaURLs[i].contains('http://') ||
                                        mediaURLs[i].contains('https://')
                                    ? CachedNetworkImage(
                                        imageUrl: mediaURLs[i],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            ShimmerWidget.rectangular(
                                          height: (screenWidth - 32) / 5 - 8,
                                          width: (screenWidth - 32) / 5 - 8,
                                        ),
                                      )
                                    : Image.file(File(mediaURLs[i]),
                                        fit: BoxFit.cover)
                                : _VideoItem(
                                    url: mediaURLs[i],
                                    height: (screenWidth - 32) / 5 - 8,
                                    width: (screenWidth - 32) / 5 - 8,
                                  ),
                          ),
                        ),
                      ),
                      if (onRemoveItem != null)
                        Positioned(
                          top: 1,
                          right: 1,
                          child: InkWell(
                            onTap: () {
                              onRemoveItem!(i);
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF3333),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColor.white)),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.close,
                                color: AppColor.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget buildGridLayout(double screenWidth) {
    List<Widget> children = [];
    switch (mediaURLs.length) {
      case 0:
        children = [const SizedBox()];
        break;
      case 1:
        children = [_OneSquare(url: mediaURLs[0], height: screenWidth)];
        break;

      case 2:
        children = [_TwoSquare(listURL: mediaURLs, height: screenWidth)];
        break;

      case 3:
        children = [
          _ThreeSquare(
            listURL: mediaURLs,
            height: screenWidth,
          )
          // _OneSquare(url: mediaURLs[0], height: screenWidth / 2),
          // const SizedBox(height: 5),
          // _TwoSquare(listURL: mediaURLs.sublist(1), height: screenWidth)
        ];
        break;

      case 4:
        children = [
          _TwoSquare(
            listURL: mediaURLs.sublist(0, 2),
            height: screenWidth,
          ),
          const SizedBox(height: 5),
          _TwoSquare(
            listURL: mediaURLs.sublist(2),
            height: screenWidth,
          )
        ];
        break;

      case 5:
        children = [
          _TwoSquare(
            listURL: mediaURLs.sublist(0, 2),
            height: screenWidth,
          ),
          const SizedBox(height: 5),
          _ThreeSquare(listURL: mediaURLs.sublist(2), height: screenWidth)
        ];
        break;
      default:
        children = [
          _ThreeSquare(listURL: mediaURLs.sublist(0, 3), height: screenWidth),
          const SizedBox(height: 5),
          _ThreeSquare(listURL: mediaURLs.sublist(3), height: screenWidth)
        ];
        break;
    }
    return Column(children: children);
  }
}

class _VideoItem extends StatefulWidget {
  const _VideoItem({
    required this.url,
    required this.width,
    required this.height,
  });
  final String url;
  final double width;
  final double height;

  @override
  State<_VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<_VideoItem> {
  bool isNetworkVideo = false;
  Uint8List? thumbnail;

  @override
  void initState() {
    _getThumbnail();
    super.initState();
  }

  Future<void> _getThumbnail() async {
    final thumb = await VideoThumbnail.thumbnailData(
        video: widget.url,
        imageFormat: ImageFormat.JPEG,
        maxHeight:
            64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 100);
    if (thumb != null) {
      setState(() {
        thumbnail = thumb;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: thumbnail == null
          ? ShimmerWidget.rectangular(
              height: widget.height,
              width: widget.width,
            )
          : Image.memory(thumbnail!, fit: BoxFit.cover),
    );
  }
}

class _OneSquare extends StatelessWidget {
  const _OneSquare({
    required this.url,
    this.height,
  });
  final String url;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return _ImageWidget(
      height: height ?? screenSize.width,
      width: height ?? screenSize.width,
      url: url,
    );
  }
}

class _TwoSquare extends StatelessWidget {
  const _TwoSquare({required this.listURL, this.height});
  final List<dynamic> listURL;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ImageWidget(
            height: (height ?? screenSize.width) / 2 - 2.5,
            width: (height ?? screenSize.width) / 2 - 2.5,
            url: listURL[0]),
        _ImageWidget(
            height: (height ?? screenSize.width) / 2 - 2.5,
            width: (height ?? screenSize.width) / 2 - 2.5,
            url: listURL[1]),
      ],
    );
  }
}

class _ThreeSquare extends StatelessWidget {
  const _ThreeSquare({required this.listURL, this.height});
  final List<dynamic> listURL;
  final double? height;

  @override
  Widget build(BuildContext context) {
    print('check lenght ${listURL.length}');
    final screenSize = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ImageWidget(
            height: (height ?? screenSize.width) / 3 - 3.3,
            width: (height ?? screenSize.width) / 3 - 3.3,
            url: listURL[0]),
        _ImageWidget(
            height: (height ?? screenSize.width) / 3 - 3.3,
            width: (height ?? screenSize.width) / 3 - 3.3,
            url: listURL[1]),
        SizedBox(
          height: (height ?? screenSize.width) / 3 - 3.3,
          width: (height ?? screenSize.width) / 3 - 3.3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _ImageWidget(
                  height: (height ?? screenSize.width) / 3 - 3.3,
                  width: (height ?? screenSize.width) / 3 - 3.3,
                  url: listURL[2]),
              if (listURL.length > 3)
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text('+${listURL.length - 3}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white)),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class _ImageWidget extends StatefulWidget {
  const _ImageWidget({
    required this.height,
    required this.width,
    required this.url,
  });
  final double height;
  final double width;
  final String url;

  @override
  State<_ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<_ImageWidget> {
  bool isImage = true;

  @override
  void initState() {
    isImage = Utils.isImageFile(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhotoPreviewScreen(url: widget.url)));
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: isImage
            ? widget.url.contains('http://') || widget.url.contains('https://')
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      imageUrl: widget.url,
                      fit: BoxFit.cover,
                      height: widget.height,
                      width: widget.width,
                      placeholder: (context, url) => ShimmerWidget.rectangular(
                          height: widget.height, width: widget.width),
                    ),
                  )
                : Image.file(
                    File(widget.url),
                    fit: BoxFit.cover,
                  )
            : Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: _VideoItem(
                      url: widget.url,
                      width: widget.width,
                      height: widget.height,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black54,
                      ),
                      child: Icon(
                        Icons.play_circle_outline_outlined,
                        color: AppColor.white,
                        size: widget.width * .3,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
