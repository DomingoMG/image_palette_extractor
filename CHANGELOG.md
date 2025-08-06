## 1.0.1
- ➕ Added `extractDominantColorFromPixels` method to support isolate-safe color extraction.
- 🔁 Enables processing of raw RGBA `Uint8List` pixel data (e.g., from `ui.Image.toByteData`).
- 🧵 Allows integration with `Isolate.run()` or `compute()` to avoid UI thread blocking.
- 📖 Updated README with usage example for isolate-based color extraction.

## 1.0.0+1
- Readme updated.

## 1.0.0
- 🚀 Stable release with extended functionality.
- ✅ Added support for extracting dominant color and palette from:
  - Local image files (`File`)
  - Flutter in-memory images (`ui.Image`)
  - Specific regions within a `ui.Image` using `Rect`.
- 💡 Improved architecture with SOLID principles and clean code practices.
- 🧪 Added full test coverage for all supported use cases.
- 🧰 Better separation of concerns using `ImageLoader` and `ColorAnalyzer` classes.
- 📚 Full documentation for all public APIs.

## 0.0.1
- Initial release of `image_palette_extractor`.
- Provides utilities to extract the dominant color from an image.
- Supports color palette extraction from network images.
- Allows setting the number of dominant colors to extract.
- Built-in support for `http` and `image` packages.
- Useful for dynamic theming and UI customization based on image content.