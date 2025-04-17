// ignore_for_file: prefer_const_constructors

import 'package:blinqpay/Utilities/Functions/theme_coloring.dart';
import 'package:blinqpay/Utilities/Functions/time_formatter.dart';
import 'package:blinqpay/Utilities/app_colors.dart';
import 'package:blinqpay/Utilities/reusables.dart';
import 'package:blinqpay/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostCard extends StatefulWidget {
  final QueryDocumentSnapshot post;
  const PostCard({required this.post});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  VideoPlayerController? _videoController;
  bool isExpanded = false;
  bool showSeeMore = false;

  @override
  void initState() {
    super.initState();
    final postData = widget.post.data() as Map<String, dynamic>;
    if (!postData['no_media'] && postData['video'] == 'true') {
      _videoController = VideoPlayerController.network(postData['link'])
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _handleVisibility(VisibilityInfo info) {
    if (_videoController != null) {
      if (info.visibleFraction > 0.6) {
        _videoController?.play();
      } else {
        _videoController?.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final post = widget.post.data() as Map<String, dynamic>;
    final isText = post['no_media'] == true;
    final isImage = !post['no_media'] && post['video'] == 'false';
    final isVideo = !post['no_media'] && post['video'] == 'true';
    final String thumbnail =
        post['thumbnail'] ?? "https://i.pravatar.cc/150?u=${post['userId']}";

    return VisibilityDetector(
      key: Key(widget.post.id),
      onVisibilityChanged: _handleVisibility,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * size.width / 100,
          vertical: 0.7 * size.height / 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kTxt(
                      text: post['username'] ?? 'User',
                      weight: FontWeight.w600,
                      size: 16,
                      color: themedColor(
                        light: kColors.blackColor,
                        dark: kColors.whiteColor,
                      ),
                    ),
                    kTxt(
                      text: timeAgo(post['timestamp']),
                      size: 12,
                      color: themedColor(
                        light: kColors.textGrey,
                        dark: kColors.whitishGrey.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Height(h: 1),
            LayoutBuilder(
              builder: (context, constraints) {
                final span = TextSpan(
                  text: post['description'],
                  style: TextStyle(
                    fontFamily: 'Rany',
                    color: themedColor(
                      light: kColors.blackColor.withOpacity(0.95),
                      dark: kColors.whiteColor,
                    ),
                    fontSize: 14,
                  ),
                );

                final tp = TextPainter(
                  text: span,
                  maxLines: 4,
                  textDirection: TextDirection.ltr,
                );

                tp.layout(maxWidth: constraints.maxWidth);

                showSeeMore = tp.didExceedMaxLines;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kTxt(
                      text: post['description'],
                      maxLine: isExpanded ? 100 : 4,
                      size: 14,
                      color: themedColor(
                        light: kColors.blackColor.withOpacity(0.95),
                        dark: kColors.whiteColor,
                      ),
                      softRap: true,
                    ),
                    if (showSeeMore)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            isExpanded ? 'See less' : 'See more...',
                            style: TextStyle(
                              color: kColors.primaryColor.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rany',
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            Height(h: 1),
            if (isImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post['link'],
                ),
              ),
            if (isVideo &&
                _videoController != null &&
                _videoController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_videoController!),
                    if (!_videoController!.value.isPlaying)
                      Icon(Icons.play_circle_fill,
                          size: 64, color: Colors.white70),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
