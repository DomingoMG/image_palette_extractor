import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// A utility class that analyzes image pixel data to extract color information.
///
/// This class provides methods for retrieving the most dominant color from an image
/// and generating a palette of frequently occurring colors. It is useful for creating
/// dynamic UI themes, gradients, or background effects based on image content.
class ColorAnalyzer {
  /// Creates a new instance of [ColorAnalyzer].
  ///
  /// This class is stateless and safe to use across multiple images or isolates.
  const ColorAnalyzer();

  /// Returns the most dominant (frequent) color found in the given [image].
  ///
  /// This is commonly used to generate UI themes that match the tone of an image,
  /// similar to Spotify-style album backgrounds or Material You color schemes.
  ///
  /// Example:
  /// ```dart
  /// final analyzer = ColorAnalyzer();
  /// final color = analyzer.getDominantColor(image);
  /// ```
  ///
  /// - [image]: An instance of [img.Image] from the `image` package.
  /// - Returns a [Color] representing the most common pixel color.
  Color getDominantColor(img.Image image) {
    final Map<int, int> colorCount = {};

    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final value =
            (pixel.r.toInt() << 16) | (pixel.g.toInt() << 8) | pixel.b.toInt();

        colorCount[value] = (colorCount[value] ?? 0) + 1;
      }
    }

    final mostCommon = colorCount.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    final r = (mostCommon >> 16) & 0xFF;
    final g = (mostCommon >> 8) & 0xFF;
    final b = mostCommon & 0xFF;

    return Color.fromARGB(255, r, g, b);
  }

  /// Returns a list of the [count] most dominant colors found in the given [image].
  ///
  /// Useful for creating gradients, color schemes, or themes based on image content.
  ///
  /// Example:
  /// ```dart
  /// final palette = analyzer.getPalette(image, count: 5);
  /// ```
  ///
  /// - [image]: The source [img.Image] object.
  /// - [count]: The number of top colors to return. Defaults to 3.
  /// - Returns a list of [Color] objects sorted by frequency.
  List<Color> getPalette(img.Image image, {int count = 3}) {
    final Map<int, int> colorCount = {};

    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final value =
            (pixel.r.toInt() << 16) | (pixel.g.toInt() << 8) | pixel.b.toInt();

        colorCount[value] = (colorCount[value] ?? 0) + 1;
      }
    }

    final sortedEntries = colorCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.take(count).map((entry) {
      final color = entry.key;
      final r = (color >> 16) & 0xFF;
      final g = (color >> 8) & 0xFF;
      final b = color & 0xFF;
      return Color.fromARGB(255, r, g, b);
    }).toList();
  }

  /// Crops a rectangular region from the given [image] based on the provided [region].
  ///
  /// This can be useful for analyzing a specific area of the image, such as a thumbnail,
  /// face region, or central portion of an image.
  ///
  /// Example:
  /// ```dart
  /// final cropped = analyzer.cropImage(image, Rect.fromLTWH(0, 0, 100, 100));
  /// ```
  ///
  /// - [image]: The original [img.Image] to crop from.
  /// - [region]: A [Rect] defining the crop region in image coordinates.
  /// - Returns a new cropped [img.Image].
  img.Image cropImage(img.Image image, Rect region) {
    return img.copyCrop(
      image,
      x: region.left.toInt(),
      y: region.top.toInt(),
      width: region.width.toInt(),
      height: region.height.toInt(),
    );
  }
}
