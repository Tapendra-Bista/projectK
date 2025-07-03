import 'dart:async';
import 'dart:math';

import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/reels/bloc/reel_bloc.dart';
import 'package:afriqueen/features/reels/model/reel_model.dart';
import 'package:afriqueen/features/reels/widget/reels_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whitecodel_reels/models/video_model.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final videoProgressController = StreamController<double>.broadcast();
  final videoBufferController = StreamController<double>.broadcast();
  final random = Random();

  VoidCallback? _videoListener;

  @override
  void dispose() {
    // Clean up all stream controllers and listeners
    videoProgressController.close();
    videoBufferController.close();
    _videoListener = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ReelBloc, ReelState, List<ReelModel>>(
      selector: (state) {
        if (state is Initial) return state.reelModel;

        return [];
      },
      builder: (context, reelData) {
        return WhiteCodelReels(
          videoList: reelData
              .map((item) => VideoModel(
                    url: item.reelUrl,
                  ))
              .toList(),
          startIndex: reelData.isNotEmpty ? random.nextInt(reelData.length) : 0,
          isCaching: true,
          context: context,
          loader: const CustomCircularIndicator(),
          builder:
              (context, index, child, videoPlayerController, pageController) {
            // Prevent duplicate listener
            if (_videoListener != null) {
              videoPlayerController.removeListener(_videoListener!);
            }

            _videoListener = () {
              final duration = videoPlayerController.value.duration;
              final position = videoPlayerController.value.position;
              final buffered = videoPlayerController.value.buffered;

              if (duration.inMilliseconds == 0) return;

              if (!videoProgressController.isClosed) {
                videoProgressController.add(
                  position.inMilliseconds / duration.inMilliseconds,
                );
              }

              if (!videoBufferController.isClosed) {
                final bufferEnd =
                    buffered.isNotEmpty ? buffered.last.end.inMilliseconds : 0;
                videoBufferController.add(
                  bufferEnd / duration.inMilliseconds,
                );
              }
            };

            videoPlayerController.addListener(_videoListener!);

            if (!videoPlayerController.value.isInitialized) {
              return const Center(child: CustomCircularIndicator());
            }

            return Stack(
              children: [
                child,
                ReelDescription(
                  reelData: reelData[index],
                ),
                VirticalActionWidgets(
                  reelData: reelData[index],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: StreamBuilder<double>(
                    stream: videoBufferController.stream,
                    builder: (_, snapshot) => SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: SliderComponentShape.noThumb,
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 2,
                      ),
                      child: Slider(
                        value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                        onChanged: (_) {},
                        min: 0,
                        max: 1,
                        activeColor: Colors.grey,
                        inactiveColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: StreamBuilder<double>(
                    stream: videoProgressController.stream,
                    builder: (_, snapshot) => SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: SliderComponentShape.noThumb,
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 2,
                      ),
                      child: Slider(
                        value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                        min: 0,
                        max: 1,
                        activeColor: AppColors.floralWhite,
                        inactiveColor: Colors.transparent,
                        onChanged: (value) {
                          final newPosition =
                              videoPlayerController.value.duration * value;
                          videoPlayerController.seekTo(newPosition);
                        },
                        onChangeEnd: (_) {
                          videoPlayerController.play();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
