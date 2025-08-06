import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_palette_extractor/src/core/core.dart';
import 'package:image_palette_extractor/src/utils/ui_image_utils.dart';

/// Provides high-level APIs to extract dominant colors and color palettes from images.
///
/// This class supports different image sources such as:
/// - Remote images from a URL
/// - Local image files
/// - In-memory [ui.Image] objects (e.g., decoded with Flutter's `ImageProvider`)
///
/// It is designed to help developers build dynamic and adaptive UIs based on image content,
/// for use cases such as media players, photo editors, theming, or artistic visualizations.
class ImagePaletteExtractor {
  final ImageLoader _loader;
  final ColorAnalyzer _analyzer;

  /// Creates a new instance of [ImagePaletteExtractor].
  ///
  /// You may optionally provide custom [ImageLoader] and [ColorAnalyzer] implementations
  /// for testing or advanced use cases.
  const ImagePaletteExtractor({
    ImageLoader loader = const ImageLoader(),
    ColorAnalyzer analyzer = const ColorAnalyzer(),
  }) : _loader = loader,
       _analyzer = analyzer;

  // ────────────────────────────────────────────────────────────────
  // 🌐 NETWORK IMAGE METHODS
  // ────────────────────────────────────────────────────────────────

  /// Extracts the dominant color from an image fetched from a [url].
  ///
  /// Returns `null` if the image could not be loaded or decoded.
  ///
  /// Example:
  /// ```dart
  /// final color = await extractor.extractDominantColorFromUrl('https://example.com/image.jpg');
  /// ```
  Future<Color?> extractDominantColorFromUrl(String url) async {
    final image = await _loader.loadFromUrl(url);
    if (image == null) return null;
    return _analyzer.getDominantColor(image);
  }

  /// Extracts a palette of dominant colors from an image fetched from a [url].
  ///
  /// The [count] parameter controls the number of dominant colors to return.
  /// Defaults to 3.
  ///
  /// Returns an empty list if the image could not be loaded or decoded.
  Future<List<Color>> extractPaletteFromUrl(String url, {int count = 3}) async {
    final image = await _loader.loadFromUrl(url);
    if (image == null) return [];
    return _analyzer.getPalette(image, count: count);
  }

  // ────────────────────────────────────────────────────────────────
  // 📁 FILE IMAGE METHODS
  // ────────────────────────────────────────────────────────────────

  /// Extracts the dominant color from a local image [file].
  ///
  /// Returns `null` if the file is invalid or unreadable.
  ///
  /// Example:
  /// ```dart
  /// final color = await extractor.extractDominantColorFromFile(File('image.jpg'));
  /// ```
  Future<Color?> extractDominantColorFromFile(File file) async {
    final image = await _loader.loadFromFile(file);
    if (image == null) return null;
    return _analyzer.getDominantColor(image);
  }

  /// Extracts a color palette from a local image [file].
  ///
  /// The [count] parameter defines how many dominant colors to return. Defaults to 3.
  ///
  /// Returns an empty list if the file is invalid or unreadable.
  Future<List<Color>> extractPaletteFromFile(File file, {int count = 3}) async {
    final image = await _loader.loadFromFile(file);
    if (image == null) return [];
    return _analyzer.getPalette(image, count: count);
  }

  // ────────────────────────────────────────────────────────────────
  // 🖼️ FLUTTER UI.IMAGE METHODS
  // ────────────────────────────────────────────────────────────────

  /// Extracts the dominant color from a decoded [ui.Image].
  ///
  /// Returns `null` if the conversion to a processable format fails.
  Future<Color?> extractDominantColorFromUiImage(ui.Image uiImage) async {
    final image = await convertUiImageToImgImage(uiImage);
    if (image == null) return null;
    return _analyzer.getDominantColor(image);
  }

  /// Extracts a palette of dominant colors from a [ui.Image].
  ///
  /// The [count] parameter controls the number of colors to return. Defaults to 3.
  ///
  /// Returns an empty list if the conversion fails.
  Future<List<Color>> extractPaletteFromUiImage(
    ui.Image uiImage, {
    int count = 3,
  }) async {
    final image = await convertUiImageToImgImage(uiImage);
    if (image == null) return [];
    return _analyzer.getPalette(image, count: count);
  }

  // ────────────────────────────────────────────────────────────────
  // 🔲 UI.IMAGE REGION METHODS
  // ────────────────────────────────────────────────────────────────

  /// Extracts the dominant color from a specific [region] of a [ui.Image].
  ///
  /// This is useful for analyzing focal areas like thumbnails or avatars.
  ///
  /// Returns `null` if the image could not be converted or cropped.
  Future<Color?> extractDominantColorFromUiImageRegion(
    ui.Image uiImage,
    Rect region,
  ) async {
    final image = await convertUiImageToImgImage(uiImage);
    if (image == null) return null;
    final cropped = _analyzer.cropImage(image, region);
    return _analyzer.getDominantColor(cropped);
  }

  /// Extracts a palette of dominant colors from a specific [region] of a [ui.Image].
  ///
  /// The [count] parameter defines how many colors to return. Defaults to 3.
  ///
  /// Returns an empty list if the image could not be converted or cropped.
  Future<List<Color>> extractPaletteFromUiImageRegion(
    ui.Image uiImage,
    Rect region, {
    int count = 3,
  }) async {
    final image = await convertUiImageToImgImage(uiImage);
    if (image == null) return [];
    final cropped = _analyzer.cropImage(image, region);
    return _analyzer.getPalette(cropped, count: count);
  }
}
