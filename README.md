# 🎨 image_palette_extractor
A Flutter plugin for extracting the dominant color or a color palette from an image.  
It supports dynamic UI effects like those seen in Spotify, Apple Music, and other media-rich apps.

---
## 🚀 Installation
Add this to your `pubspec.yaml`:

```yaml
dependencies:
  image_palette_extractor: ^1.0.1
```

---
## 📦 Required dependencies
```yaml
dependencies:
  image: ^4.0.17
  http: ^1.1.0
```

---
## 🧠 Features
| Method                                     | Description                                                           |
|--------------------------------------------|-----------------------------------------------------------------------|
| `extractDominantColorFromUrl`              | Extracts the most frequent color from a remote image                 |
| `extractPaletteFromUrl`                    | Extracts a palette of dominant colors from a remote image            |
| `extractDominantColorFromFile`             | Extracts the dominant color from a local image file                  |
| `extractPaletteFromFile`                   | Extracts a color palette from a local image file                     |
| `extractDominantColorFromUiImage`          | Extracts dominant color from an in-memory `ui.Image`                 |
| `extractPaletteFromUiImage`                | Extracts a palette from a `ui.Image`                                 |
| `extractDominantColorFromUiImageRegion`    | Extracts dominant color from a rectangular region of a `ui.Image`    |
| `extractPaletteFromUiImageRegion`          | Extracts palette from a rectangular region of a `ui.Image`           |
| `extractDominantColorFromPixels`           | Extracts dominant color from raw RGBA pixel data (e.g. for isolates) |

---
## ✨ Example usage
### 🎯 Dominant color from URL
```dart
final extractor = ImagePaletteExtractor();
final color = await extractor.extractDominantColorFromUrl('https://example.com/image.jpg');

if (color != null) {
  print('Dominant: ${color.red}, ${color.green}, ${color.blue}');
}
```

---
### 🎨 Color palette from URL
```dart
final palette = await extractor.extractPaletteFromUrl('https://example.com/image.jpg', count: 3);
for (final color in palette) {
  print('Color: ${color.value.toRadixString(16)}');
}
```

---
### 📁 From file
```dart
final file = File('/path/to/image.jpg');
final dominant = await extractor.extractDominantColorFromFile(file);
final palette = await extractor.extractPaletteFromFile(file, count: 5);
```

---
### 🖼️ From ui.Image region
```dart
final region = Rect.fromLTWH(10, 10, 100, 100);
final dominant = await extractor.extractDominantColorFromUiImageRegion(myUiImage, region);
final palette = await extractor.extractPaletteFromUiImageRegion(myUiImage, region, count: 4);
```

---
### ⚡️ From raw pixels (for isolate use)
```dart
final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
if (byteData != null) {
  final pixels = byteData.buffer.asUint8List();

  final color = await Isolate.run(() async {
    final extractor = ImagePaletteExtractor();
    return await extractor.extractDominantColorFromPixels(
      pixels,
      uiImage.width,
      uiImage.height,
    );
  });

  if (color != null) {
    print('Dominant (isolate): ${color.red}, ${color.green}, ${color.blue}');
  }
}
```

---
### 🖌️ Apply palette as background
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: palette,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: const Text('Dynamic background'),
)
```

---
## ✅ Running tests
```bash
flutter test
```

---
## 📁 Project structure
```
lib/
├── image_palette_extractor.dart           # Main export
└── src/
    ├── core/
    │   ├── color_analyzer.dart            # Color analysis logic
    │   └── image_loader.dart              # Load images from URL or File
    ├── utils/
    │   └── ui_image_utils.dart            # Convert ui.Image to image.Image
    └── palette_extractor.dart             # High-level entry point for consumers
```
