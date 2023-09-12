class Video {
  String url = 'https://www.youtube.com/shorts/ULx6VJC2cEo';
  String modelName = 'Calico';
  List items = [];

  Video({
    String? videoURL,
    String? videoModelName,
    List? videoItems,
  }) {
    url = videoURL ?? url;
    modelName = videoModelName ?? modelName;
    items = videoItems ?? items;
  }
}
