import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';

class CourseState {
  final bool isLoading;
  final List<CourseEntity> courses;
  final String? error;

  CourseState({required this.isLoading, required this.courses, this.error});

  factory CourseState.initial() {
    return CourseState(isLoading: false, courses: []);
  }

  CourseState copyWith({
    bool? isLoading,
    List<CourseEntity>? courses,
    String? error,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      error: error ?? this.error,
    );
  }
}
