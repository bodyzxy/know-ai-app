class DrawOption {
  String model;
  int width;
  int height;
  String format;

  DrawOption(this.model, this.width, this.height, this.format);

  @override
  String toString() {
    return 'DrawOption{model: $model, width: $width, height: $height, format: $format}';
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'width': width,
      "height": height,
      "format": format
    };
  }
}