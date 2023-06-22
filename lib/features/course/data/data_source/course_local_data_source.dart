import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/core/network/local/hive_service.dart';
import 'package:hive_and_api_for_class/features/course/data/model/course_hive_model.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';

final courseLocalDataSourceProvider = Provider(
  (ref) => CourseLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      courseHiveModel: ref.read(
        courseHiveModelProvider,
      )),
);

class CourseLocalDataSource {
  final HiveService hiveService;
  final CourseHiveModel courseHiveModel;

  CourseLocalDataSource({
    required this.hiveService,
    required this.courseHiveModel,
  });

  // Add batch
  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try {
      //convert entity to hive object
      final hiveCourse = courseHiveModel.toHiveModel(course);
      // Add to hive
      await hiveService.addCourse(hiveCourse);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //get all batch
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      //get all batches from hive
      final courses = await hiveService.getAllCourses();
      // convert hive object into entity
      final courseEntities = courseHiveModel.toEntityList(courses);
      return Right(courseEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
