class PostWatchlist {
  bool? success;
  int? status_code;
  String? status_message;
  String? media_type;
  int? media_id;
  bool? watchlist;

  PostWatchlist({
    this.success,
    this.status_code,
    this.status_message,
    this.media_type,
    this.media_id,
    this.watchlist,
  });

  factory PostWatchlist.fromJson(Map<String, dynamic> json) {
    return PostWatchlist(
      success: json['success'] as bool,
      status_code: json['status_code'] as int,
      status_message: json['status_massage'] as String,
      media_type: json['media_type'] as String,
      media_id: json['media_id'] as int,
      watchlist: json['watchlist'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': status_code,
      'status_message': status_message,
      'media_type': media_type,
      'media_id': media_id,
      'watchlist': watchlist,
    };
  }
}
