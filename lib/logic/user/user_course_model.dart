class UserCourseModel {
  String id;
  String courseId;
  String startedAt;
  String expiryDate;
  int currentLessonNumber;
  int currentSubjectNumber;
  bool finished;
  String licenseCode;
  int active;
  bool pendingApproval;

  UserCourseModel(
      {required this.id,
      required this.courseId,
      required this.startedAt,
      required this.expiryDate,
      required this.currentLessonNumber,
      required this.currentSubjectNumber,
      required this.finished,
      required this.licenseCode,
      required this.active,
      required this.pendingApproval});

  static UserCourseModel fromJson(dynamic json) {
    return UserCourseModel(
      id: json['id'].toString(),
      courseId: json['courseId'],
      startedAt: json['startedAt'],
      expiryDate: json['expiryDate'],
      currentLessonNumber: json['currentLessonNumber'],
      currentSubjectNumber: json['currentSubjectNumber'],
      finished: json['finished'],
      licenseCode: json['licenseCode'],
      active: json['active'],
      pendingApproval: json['pendingApproval'] ?? false,
    );
  }
}
