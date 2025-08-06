import 'package:flutter_test/flutter_test.dart';
import 'package:image_palette_extractor/image_palette_extractor.dart';

void main() {
  group('ImagePaletteExtractor', () {
    final extractor = ImagePaletteExtractor();

    test('extracts dominant color from a red image', () async {
      const url =
          'https://img.freepik.com/foto-gratis/fondo-papel-rojo-elegante-fondo-escarlata-decoracion-navidena-o-textura-papel-diseno-web_166373-2152.jpg';
      final color = await extractor.extractDominantColorFromUrl(url);
      final int argb = color!.toARGB32();
      final red = (argb >> 16) & 0xFF;
      final green = (argb >> 8) & 0xFF;
      final blue = argb & 0xFF;

      expect(red, inInclusiveRange(100, 255));
      expect(green, lessThan(100));
      expect(blue, lessThan(100));
    });

    test('extracts palette from the "Pain" album cover', () async {
      const url =
          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1735798846';
      final palette = await extractor.extractPaletteFromUrl(url, count: 3);

      expect(palette, isNotEmpty);
      expect(palette.length, lessThanOrEqualTo(3));

      final dominantColor = palette.first;
      final argb = dominantColor.toARGB32();
      final red = (argb >> 16) & 0xFF;
      final green = (argb >> 8) & 0xFF;
      final blue = argb & 0xFF;

      // Purple/pink expected: high red and blue, low green
      expect(red, greaterThan(150));
      expect(blue, greaterThan(100));
      expect(green, lessThan(150));
    });

    test('handles unreachable URL gracefully', () async {
      const url = 'https://this-link-does-not-exist.com/invalid-image.jpg';

      final color = await extractor.extractDominantColorFromUrl(url);
      final palette = await extractor.extractPaletteFromUrl(url, count: 3);

      expect(color, isNull);
      expect(palette, isEmpty);
    });
  });
}
