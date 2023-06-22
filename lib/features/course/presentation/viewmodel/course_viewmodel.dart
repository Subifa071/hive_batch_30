import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';
import 'package:hive_and_api_for_class/features/course/domain/use_case/course_usecase.dart';
import 'package:hive_and_api_for_class/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>(
  (ref) => CourseViewModel(ref.read(courseUseCaseProvider)),
);

class CourseViewModel extends StateNotifier<CourseState> {
  final CourseUseCase courseUseCase;

  CourseViewModel(this.courseUseCase) : super(CourseState.initial()) {
    getAllCourses();
  }

  Future<void> addCourse(CourseEntity course) async {
    state.copyWith(isLoading: true);
    var data = await courseUseCase.addCourse(course);

    data.fold(
      (l) => state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> getAllCourses() async {
    state.copyWith(isLoading: true);
    var data = await courseUseCase.getAllCourses();

    data.fold(
      (l) => state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, courses: r, error: null),
    );
  }
}
