import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:image_palette_extractor/src/core/color_analyzer.dart';

void main() {
  group('ColorAnalyzer', () {
    final analyzer = ColorAnalyzer();

    test('extracts dominant color from a solid red image', () {
      final redImage = img.Image(width: 10, height: 10);

      for (var y = 0; y < redImage.height; y++) {
        for (var x = 0; x < redImage.width; x++) {
          redImage.setPixelRgb(x, y, 255, 0, 0); // Red
        }
      }

      final dominant = analyzer.getDominantColor(redImage);
      expect(dominant, equals(const Color.fromARGB(255, 255, 0, 0)));
    });

    test('extracts correct number of palette colors', () {
      final image = img.Image(width: 2, height: 1);
      image.setPixelRgb(0, 0, 255, 0, 0); // Red
      image.setPixelRgb(1, 0, 0, 255, 0); // Green

      final palette = analyzer.getPalette(image, count: 2);

      expect(palette.length, equals(2));
      expect(palette[0], isA<Color>());
      expect(palette[1], isA<Color>());
    });
  });
}
