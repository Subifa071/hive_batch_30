import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';

import '../../data/repository/course_remote_repo_impl.dart';

final courseRepositoryProvider = Provider<ICourseRepository>((ref) {
  // Return Local repository implementation
  // return ref.read(courseLocalRepoProvider);

  // For internet connectivity we will check later
  return ref.read(courseRemoteRepoProvider);
});

abstract class ICourseRepository {
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
}
