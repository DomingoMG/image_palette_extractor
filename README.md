# 🎨 image_palette_extractor
A Flutter plugin for extracting the dominant color or a color palette from an image, ideal for dynamic UI effects similar to Spotify or Apple Music.

---
## 🚀 Installation
Add to your `pubspec.yaml`:

```yaml
dependencies:
  image_palette_extractor: ^1.0.0
```
> Update the path accordingly if publishing to pub.dev.

---
## 📦 Required dependencies
```yaml
dependencies:
  image: ^4.0.17
  http: ^1.1.0
```

---
## 🧠 Features
| Method                          | Description                                      |
|---------------------------------|--------------------------------------------------|
| `extractDominantColorFromUrl`   | Returns the most frequent color from an image   |
| `extractPaletteFromUrl`         | Returns a list of dominant colors for gradients |

---
## ✨ Example usage

### 🎯 Dominant color
```dart
final color = await extractDominantColorFromUrl('https://example.com/image.jpg');

if (color != null) {
  print('Dominant: ${color.red}, ${color.green}, ${color.blue}');
}
```

---
### 🎨 Color palette
```dart
final palette = await extractPaletteFromUrl('https://example.com/image.jpg', count: 3);

for (final color in palette) {
  print('Color: ${color.value.toRadixString(16)}');
}
```

---
### 🖌️ Apply as gradient background
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
├── image_palette_extractor.dart         // Main export file
└── src/
    ├── image_loader.dart                // Loads and decodes images
    └── palette_extractor.dart           // Color extraction logic
```