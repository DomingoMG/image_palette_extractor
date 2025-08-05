library;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

/// Loads an image from a network URL and decodes it into an [img.Image].
Future<img.Image?> loadImageFromUrl(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return img.decodeImage(Uint8List.fromList(response.bodyBytes));
    }
  } catch (_) {
    // Handle or log error
  }
  return null;
}

/// Extracts the dominant color from a decoded [img.Image].
Color getDominantColor(img.Image image) {
  final Map<int, int> colorCount = {};

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();
      final pixelValue = (r << 16) | (g << 8) | b;
      colorCount[pixelValue] = (colorCount[pixelValue] ?? 0) + 1;
    }
  }

  final sorted = colorCount.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  final mostCommon = sorted.first.key;

  final r = (mostCommon >> 16) & 0xFF;
  final g = (mostCommon >> 8) & 0xFF;
  final b = mostCommon & 0xFF;

  return Color.fromARGB(255, r, g, b);
}

/// Extracts the dominant color from a network image URL.
Future<Color?> extractDominantColorFromUrl(String imageUrl) async {
  final image = await loadImageFromUrl(imageUrl);
  if (image == null) return null;
  return getDominantColor(image);
}

/// Extracts a list of the most common colors in the image (used for gradients).
Future<List<Color>> extractPaletteFromUrl(
  String imageUrl, {
  int count = 3,
}) async {
  final image = await loadImageFromUrl(imageUrl);
  if (image == null) return [];

  final Map<int, int> colorCount = {};

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();
      final pixelValue = (r << 16) | (g << 8) | b;
      colorCount[pixelValue] = (colorCount[pixelValue] ?? 0) + 1;
    }
  }

  final sorted = colorCount.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sorted.take(count).map((entry) {
    final value = entry.key;
    final r = (value >> 16) & 0xFF;
    final g = (value >> 8) & 0xFF;
    final b = value & 0xFF;
    return Color.fromARGB(255, r, g, b);
  }).toList();
}
