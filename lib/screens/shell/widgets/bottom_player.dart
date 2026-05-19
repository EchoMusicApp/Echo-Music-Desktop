import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:Echo/services/media_player.dart';
import 'package:Echo/utils/adaptive_widgets/buttons.dart';
import 'package:Echo/utils/adaptive_widgets/listtile.dart';
import 'package:Echo/utils/adaptive_widgets/progress_ring.dart';
import 'package:Echo/utils/song_thumbnail.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:Echo/utils/bottom_modals.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  Color? backgroundColor;



  void updateBackgroundColor(ImageProvider image) async {
    final palette = await PaletteGenerator.fromImageProvider(
      image,
      maximumColorCount: 20,
    );
    if (mounted) {
      if (palette.dominantColor != null &&
          backgroundColor != palette.dominantColor!.color) {
        setState(() {
          backgroundColor = palette.dominantColor!.color;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaPlayer = GetIt.I<MediaPlayer>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return StreamBuilder(
        stream: mediaPlayer.currentTrackStream,
        builder: (
          context,
          snapshot,
        ) {
          final data = snapshot.data;
          final currentSong = data?.currentItem;
          if (currentSong == null) {
            return const SizedBox(); // or loading indicator
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: GestureDetector(
              onTap: () {
                context.push('/player');
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: (backgroundColor ?? (isDark ? const Color(0xFF1E1E2E) : const Color(0xFFFFFFFF)))
                            .withValues(alpha: isDark ? 0.45 : 0.65),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15),
                          width: 1.2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8), // Adjusted padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // LEFT: Song Info (Art + Text)
                          Expanded(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SongThumbnail(
                                    song: currentSong.extras!,
                                    dp: MediaQuery.of(context)
                                        .devicePixelRatio,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fill,
                                    onImageReady: updateBackgroundColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: isDark ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                      if (currentSong.artist != null ||
                                          currentSong.extras!['subtitle'] !=
                                              null)
                                        Text(
                                          currentSong.artist ??
                                              currentSong
                                                  .extras!['subtitle'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                (isDark ? Colors.white : Colors.black87).withValues(alpha: 0.7),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // RIGHT: Controls (Prev, Play/Pause, Next)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StreamBuilder(
                                stream: context
                                    .watch<MediaPlayer>()
                                    .player
                                    .sequenceStateStream,
                                builder: (context, snapshot) {
                                  return AdaptiveIconButton(
                                    onPressed: () {
                                      GetIt.I<MediaPlayer>()
                                          .player
                                          .seekToPrevious();
                                    },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      size: 24,
                                      color: isDark ? Colors.white : Colors.black87,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 4),
                              ValueListenableBuilder(
                                valueListenable:
                                    GetIt.I<MediaPlayer>().buttonState,
                                builder: (context, buttonState, child) {
                                  return (buttonState == ButtonState.loading)
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: AdaptiveProgressRing(),
                                        )
                                      : AdaptiveIconButton(
                                          onPressed: () {
                                            GetIt.I<MediaPlayer>()
                                                    .player
                                                    .playing
                                                ? GetIt.I<MediaPlayer>()
                                                    .player
                                                    .pause()
                                                : GetIt.I<MediaPlayer>()
                                                    .player
                                                    .play();
                                          },
                                          icon: Icon(
                                            buttonState ==
                                                    ButtonState.playing
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 30, // Slightly smaller play button
                                            color: isDark ? Colors.white : Colors.black87,
                                          ),
                                        );
                                },
                              ),
                              const SizedBox(width: 4),
                              StreamBuilder(
                                stream: context
                                    .watch<MediaPlayer>()
                                    .player
                                    .sequenceStateStream,
                                builder: (context, snapshot) {
                                  return AdaptiveIconButton(
                                    onPressed: () {
                                      GetIt.I<MediaPlayer>()
                                          .player
                                          .seekToNext();
                                    },
                                    icon: Icon(
                                      Icons.skip_next,
                                      size: 24,
                                      color: isDark ? Colors.white : Colors.black87,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        });
  }
}
