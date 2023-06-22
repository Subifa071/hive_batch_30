// import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';
import 'package:json_annotation/json_annotation.dart';

// import 'package:student_clean_arch/features/course/domain/entity/course_entity.dart';

// dart run build_runner build --delete-conflicting-outputs
part 'course_api_model.g.dart';

final courseApiModelProvider = Provider<CourseApiModel>(
  (ref) => const CourseApiModel.empty(),
);

@JsonSerializable()
class CourseApiModel {
  @JsonKey(name: '_id')
  final String? courseId;
  final String courseName;

  const CourseApiModel({
    required this.courseId,
    required this.courseName,
  });
  const CourseApiModel.empty()
      : courseId = '',
        courseName = '';

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  // Convert API Object to Entity
  CourseEntity toEntity() => CourseEntity(
        courseId: courseId,
        courseName: courseName,
      );

  // Convert Entity to API Object
  CourseApiModel fromEntity(CourseEntity entity) => CourseApiModel(
        courseId: entity.courseId ?? '',
        courseName: entity.courseName,
      );

  // Convert API List to Entity List
  List<CourseEntity> toEntityList(List<CourseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [courseId, courseName];
}
