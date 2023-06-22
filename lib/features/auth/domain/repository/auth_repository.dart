import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';

import '../../data/repository/auth_remote_repository_impl.dart';

// final authRepositoryProvider = Provider<IAuthRepository>((ref) {
//   return ref.read(authLocalRepositoryProvider);
// });

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepoProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStudent({
    required String fname,
    required String lname,
    String? image,
    required String batch,
    required List<String> courses,
    required String phone,
    required String username,
    required String password,
  });
  Future<Either<Failure, bool>> loginStudent(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
