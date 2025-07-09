// Importing necessary packages
import 'dart:async'; // For asynchronous operations
import 'dart:developer'; // For logging
import 'model/video_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // For caching files
import 'package:video_player/video_player.dart'; // For video playback

// For video model
import 'video_proxy_server.dart'; // For video proxy server

/// A service that provides methods to obtain video player controllers.
///
/// This abstract class defines the contract for services that manage
/// the creation and configuration of video player controllers.
abstract class VideoControllerService {
  /// Gets a VideoPlayerController for a given video model.
  ///
  /// [videoModel] contains the video URL and additional configuration options.
  /// [isCaching] determines whether the video should be cached for future use.
  ///
  /// Returns a [VideoPlayerController] configured for the given video.
  Future<VideoPlayerController> getControllerForVideo(
    VideoModel videoModel,
    bool isCaching,
  );
}

/// An implementation of [VideoControllerService] that supports video caching.
///
/// This service uses a [BaseCacheManager] to store and retrieve videos,
/// improving performance by reducing network requests for previously viewed videos.
class CachedVideoControllerService extends VideoControllerService {
  /// The cache manager used to store and retrieve video files.
  final BaseCacheManager _cacheManager;

  /// The proxy server used for streaming and caching videos.
  late final VideoProxyServer _proxyServer;

  /// Creates a new [CachedVideoControllerService] with the provided cache manager.
  ///
  /// [_cacheManager] is responsible for handling the caching operations.
  CachedVideoControllerService(this._cacheManager) {
    _proxyServer = VideoProxyServer(_cacheManager);
  }

  @override
  Future<VideoPlayerController> getControllerForVideo(
    VideoModel videoModel,
    bool isCaching,
  ) async {
    final url = videoModel.url;
    final headers = videoModel.httpHeaders ?? {};

    if (isCaching) {
      try {
        // Start proxy server if not running
        if (!_proxyServer.isRunning) {
          await _proxyServer.start();
        }

        // Register the URL with the proxy server and pass headers
        final proxyUrl = await _proxyServer.registerUrl(url, headers: headers);

        log('Playing video through proxy: $proxyUrl');

        // When using proxy server, we don't need to include headers in VideoPlayerController
        // since they were already passed to the proxy server
        return VideoPlayerController.networkUrl(
          Uri.parse(proxyUrl),
          // No need to include headers here as they're handled by the proxy
          videoPlayerOptions: videoModel.videoPlayerOptions,
        );
      } catch (e) {
        // Log error if encountered while setting up proxy for video
        log('Error setting up proxy for video: $e', error: e);
        // Fallback to direct network URL if proxy fails
      }
    }

    // Default to direct network URL if caching is disabled or if proxy setup failed
    log('Playing video directly: $url');
    return VideoPlayerController.networkUrl(
      Uri.parse(url),
      httpHeaders: headers,
      videoPlayerOptions: videoModel.videoPlayerOptions,
    );
  }
}
