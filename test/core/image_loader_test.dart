import 'package:flutter_test/flutter_test.dart';
import 'package:image_palette_extractor/src/core/image_loader.dart';

void main() {
  group('ImageLoader', () {
    final loader = ImageLoader();

    test('returns null for invalid image URL', () async {
      final image = await loader.loadFromUrl(
        'https://examples.com/invalid-image.jpg',
      );
      expect(image, isNull);
    });

    test('loads image from valid URL', () async {
      const url =
          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1735798846'; // Red square
      final image = await loader.loadFromUrl(url);
      expect(image, isNotNull);
    });
  });
}
