import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

/// Converts a [ui.Image] to an [img.Image] for pixel-level analysis.
///
/// This method uses [ui.ImageByteFormat.rawRgba] for precision.
/// Returns `null` if the conversion fails.
Future<img.Image?> convertUiImageToImgImage(ui.Image uiImage) async {
  final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null) return null;

  return img.Image.fromBytes(
    width: uiImage.width,
    height: uiImage.height,
    bytes: byteData.buffer,
    order: img.ChannelOrder.rgba,
  );
}
