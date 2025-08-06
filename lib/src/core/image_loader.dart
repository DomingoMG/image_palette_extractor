import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

/// A utility class for loading and decoding images from various sources.
///
/// This class provides methods to load and decode images from remote URLs
/// or local file system using the [image] package for image processing.
class ImageLoader {
  /// Creates a new instance of [ImageLoader].
  ///
  /// This class is stateless and can be reused across your application.
  const ImageLoader();

  /// Loads and decodes an image from a given [url].
  ///
  /// This method performs an HTTP GET request to fetch the image from the provided
  /// network URL. If the response is successful (status code 200), it attempts to decode
  /// the image using the `image` package.
  ///
  /// Returns an [img.Image] if the decoding is successful, or `null` if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final loader = ImageLoader();
  /// final image = await loader.loadFromUrl('https://example.com/image.jpg');
  /// ```
  Future<img.Image?> loadFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return img.decodeImage(Uint8List.fromList(response.bodyBytes));
      }
    } catch (_) {
      // Log or handle the error if necessary
    }
    return null;
  }

  /// Loads and decodes an image from a local [file].
  ///
  /// This method reads the byte content of the provided [File] and attempts to decode it
  /// using the `image` package. It is useful when handling images selected from the device
  /// or bundled with the app.
  ///
  /// Returns an [img.Image] if the decoding is successful, or `null` if the operation fails.
  ///
  /// Example:
  /// ```dart
  /// final loader = ImageLoader();
  /// final file = File('/path/to/image.png');
  /// final image = await loader.loadFromFile(file);
  /// ```
  Future<img.Image?> loadFromFile(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return img.decodeImage(bytes);
    } catch (_) {
      // Log or handle the error if necessary
    }
    return null;
  }
}
