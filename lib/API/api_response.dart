class ApiResponse {
  final result;

  ApiResponse({this.result});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      result: json['result'],
    );
  }
}