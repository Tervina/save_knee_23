String getYoutubeThumbnail(String videoUrl) {
  String id = videoUrl.substring(videoUrl.length - 11);
  return 'https://img.youtube.com/vi/${id}/0.jpg';
}
