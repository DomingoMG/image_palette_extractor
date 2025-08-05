import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

/// Loads and decodes an image from a network URL.
Future<img.Image?> loadImageFromUrl(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return img.decodeImage(Uint8List.fromList(response.bodyBytes));
    }
  } catch (_) {}
  return null;
}
