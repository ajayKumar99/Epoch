class ApiRequest {
  final String batch;
  final List<String> enrolledCourses;

  ApiRequest(
    this.batch,
    this.enrolledCourses,
  );

  Map<String , dynamic> toJson() => {
    'batch': batch,
    'enrolled_courses': enrolledCourses,
  };
}