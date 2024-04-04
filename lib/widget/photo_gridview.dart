import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_chat_pie/ultils/app_color.dart';
import 'package:package_chat_pie/ultils/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({super.key, required this.url});
  final String url;

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  late VideoPlayerController _videoController;
  bool isImage = true;

  @override
  void initState() {
    if (Utils.isImageFile(widget.url)) {
      isImage = true;
    } else {
      if (widget.url.contains('http://') || widget.url.contains('https://')) {
        _videoController =
            VideoPlayerController.networkUrl(Uri.parse(widget.url));
      } else {
        _videoController = VideoPlayerController.file(File(widget.url));
      }
      isImage = false;
      _videoController.initialize().then((value) {
        setState(() {
          print('check init');
          _videoController.play();
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          isImage
              ? PhotoView(
                  imageProvider: widget.url.contains('http')
                      ? NetworkImage(widget.url)
                      : FileImage(File(widget.url)) as ImageProvider)
              : _videoController.value.isInitialized
                  ? VideoPlayer(_videoController)
                  : const Center(child: CircularProgressIndicator()),
          Positioned(
            left: 16,
            top: MediaQuery.viewPaddingOf(context).top + 16,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade100),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// import 'dart:io';

// import 'package:chat_socket/ultils/app_color.dart';
// import 'package:chat_socket/widget/custom_cache_image.dart';
// import 'package:chewie/chewie.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class PhotoPreviewScreenV2 extends StatefulWidget {
//   const PhotoPreviewScreenV2(
//       {super.key,
//       required this.urls,
//       required this.isNetwork,
//       required this.initialPosition});

//   final List<String> urls;
//   final bool isNetwork;
//   final int initialPosition;

//   @override
//   State<PhotoPreviewScreenV2> createState() => _PhotoPreviewScreenV2State();
// }

// class _PhotoPreviewScreenV2State extends State<PhotoPreviewScreenV2> {
//   late ExtendedPageController _pageController;
//   late int currentPage;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _pageController =
//         ExtendedPageController(initialPage: widget.initialPosition);
//     currentPage = widget.initialPosition;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.black,
//       body: Stack(
//         children: <Widget>[
//           Center(
//             child: ExtendedImageGesturePageView.builder(
//                 itemCount: widget.urls.length,
//                 controller: _pageController,
//                 scrollDirection: Axis.horizontal,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentPage = index;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   if (widget.isNetwork) {
//                     if (widget.urls[index].endsWith('.mp4') ||
//                         widget.urls[index].endsWith('.avi') ||
//                         widget.urls[index].endsWith('.mov') ||
//                         widget.urls[index].endsWith('.mp3')) {
//                       Uri uri = Uri.parse(widget.urls[index]);

//                       ChewieController chewieController = ChewieController(
//                         videoPlayerController:
//                             VideoPlayerController.networkUrl(uri),
//                         // aspectRatio: 16 / 9,
//                         autoPlay: true,
//                         // Prepare the video to be played and display the first frame
//                         autoInitialize: true,

//                         // showControls: false,
//                         // Errors can occur for example when trying to play a video
//                         // from a non-existent URL
//                         errorBuilder: (context, errorMessage) {
//                           return Center(
//                             child: Text(
//                               errorMessage,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           );
//                         },
//                       );
//                       return Stack(
//                         children: [
//                           Center(
//                             child: Container(
//                               height: MediaQuery.sizeOf(context).height * 0.7,
//                               width: MediaQuery.sizeOf(context).width,
//                               color: Colors.black,
//                               child: Chewie(
//                                 controller: chewieController,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return ExtendedImage.network(
//                         widget.urls[index],
//                         fit: BoxFit.contain,
//                         enableLoadState: true,
//                         mode: ExtendedImageMode.gesture,
//                         initGestureConfigHandler: (state) => GestureConfig(
//                             inPageView: true,
//                             initialScale: 1.0,
//                             cacheGesture: false),
//                       );
//                     }
//                   } else {
//                     return ExtendedImage.file(
//                       File(widget.urls[index]),
//                       fit: BoxFit.contain,
//                       enableLoadState: true,
//                       mode: ExtendedImageMode.gesture,
//                       initGestureConfigHandler: (state) => GestureConfig(
//                           inPageView: true,
//                           initialScale: 1.0,
//                           cacheGesture: false),
//                     );
//                   }
//                 }),
//           ),
//           Positioned(
//               left: 0,
//               bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
//               child: Container(
//                 height: 60,
//                 width: MediaQuery.sizeOf(context).width,
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: widget.urls.length,
//                       itemBuilder: (BuildContext context, index) {
//                         //   return Padding(
//                         //     padding: EdgeInsets.symmetric(horizontal: 4.w),
//                         //     child: GestureDetector(
//                         //       onTap: (){
//                         //         _pageController.jumpToPage(index);
//                         //         setState(() {
//                         //           currentPage = index;
//                         //         });
//                         //       },
//                         //       child: SizedBox(
//                         //         width: 50.w,
//                         //         height: 50.w,
//                         //         child: Chewie(
//                         //           controller: chewieController,
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   );
//                         // }
//                         return Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 4),
//                           child: GestureDetector(
//                             onTap: () {
//                               _pageController.jumpToPage(index);
//                               setState(() {
//                                 currentPage = index;
//                               });
//                             },
//                             child: SizedBox(
//                               height: 50,
//                               width: 50,
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(12))),
//                                       child: _ImageWidget(
//                                         url: widget.urls[index],
//                                         height: 50,
//                                         width: 50,
//                                         onCallBack: () {
//                                           _pageController.jumpToPage(index);
//                                           setState(() {
//                                             currentPage = index;
//                                           });
//                                         },
//                                       )),
//                                   if (index != currentPage)
//                                     Positioned.fill(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         decoration: const BoxDecoration(
//                                           color: Colors.black54,
//                                           // borderRadius: BorderRadius.all(
//                                           //     Radius.circular(12))
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               )),
//           Positioned(
//             left: 16,
//             top: MediaQuery.viewPaddingOf(context).top + 16,
//             child: InkWell(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
//                 // decoration: BoxDecoration(
//                 //     shape: BoxShape.circle, color: Colors.grey.shade100),
//                 child: const Icon(
//                   Icons.close,
//                   color: AppColor.white,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class _ImageWidget extends StatefulWidget {
//   const _ImageWidget({
//     required this.height,
//     required this.width,
//     required this.url,
//     required this.onCallBack,
//   });

//   final double height;
//   final double width;
//   final String url;
//   final VoidCallback onCallBack;

//   @override
//   State<_ImageWidget> createState() => _ImageWidgetState();
// }

// class _ImageWidgetState extends State<_ImageWidget> {
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (widget.url.endsWith('.mp4') ||
//         widget.url.endsWith('.avi') ||
//         widget.url.endsWith('.mov') ||
//         widget.url.endsWith('.mp3')) {
//       Uri uri = Uri.parse(widget.url);
//       _chewieController = ChewieController(
//         videoPlayerController: VideoPlayerController.networkUrl(uri),
//         // aspectRatio: 16 / 9,
//         autoPlay: false,
//         // Prepare the video to be played and display the first frame
//         autoInitialize: true,
//         showControls: false,
//         // Errors can occur for example when trying to play a video
//         // from a non-existent URL
//         errorBuilder: (context, errorMessage) {
//           return Center(
//             child: Text(
//               errorMessage,
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         },
//       );
//     }
//   }

//   void dispose() {
//     if (mounted) {
//       // Kiểm tra định dạng và dispose chỉ khi widget còn mounted
//       if (widget.url.endsWith('.mp4') ||
//           widget.url.endsWith('.avi') ||
//           widget.url.endsWith('.mov') ||
//           widget.url.endsWith('.mp3')) {
//         _chewieController.dispose();
//       }
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.url.endsWith('.mp4') ||
//         widget.url.endsWith('.avi') ||
//         widget.url.endsWith('.mov') ||
//         widget.url.endsWith('.mp3')) {
//       // Nếu là định dạng video
//       return Container(
//         height: widget.height,
//         width: widget.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       );
//     } else {
//       // Nếu là ảnh
//       return Container(
//         height: widget.height,
//         width: widget.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//         child: CustomCacheImageWidget(
//           imageUrl: widget.url, fit: BoxFit.cover,
//           onPreviewImage: widget.onCallBack,
//           // placeHolder: "asset",
//           radius: 0,
//           height: widget.height,
//           width: widget.width,
//         ),
//       );
//     }
//   }
// }
