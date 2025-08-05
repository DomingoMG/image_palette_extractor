import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_palette_extractor/image_palette_extractor.dart';

void main() {
  group('Dominant color extraction', () {
    test('Extracts color from remote image', () async {
      final url =
          'https://img.freepik.com/foto-gratis/fondo-papel-rojo-elegante-fondo-escarlata-decoracion-navidena-o-textura-papel-diseno-web_166373-2152.jpg'; // Imagen roja
      final color = await extractDominantColorFromUrl(url);

      expect(color, isNotNull);
      final colorValue = (color!.r * 255).round() & 0xff;
      debugPrint('Color value: $colorValue');
      expect(colorValue, greaterThan(200)); // Dominante rojo
    });

    group('Color palette extraction', () {
      test('Extracts up to 5 colors from a complex gradient image', () async {
        const url =
            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1735798846';

        final palette = await extractPaletteFromUrl(url, count: 5);

        // Asegura que devuelve al menos un color
        expect(palette, isNotEmpty);

        // Máximo 5 colores
        expect(palette.length, lessThanOrEqualTo(5));

        // Validamos que el color dominante es coral-anaranjado
        final mainColor = palette.first;
        final colorRed = (mainColor.r * 255).round() & 0xff;
        final colorGreen = (mainColor.g * 255).round() & 0xff;
        final colorBlue = (mainColor.b * 255).round() & 0xff;
        expect(colorRed, greaterThan(150));
        expect(colorGreen, inInclusiveRange(70, 180));
        expect(colorBlue, lessThan(150));
      });
    });
  });
}
