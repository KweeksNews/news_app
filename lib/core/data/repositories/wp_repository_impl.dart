/* 
 * Copyright (C) 2021  Ahmad Rulim
 * 
 * This file is part of Flutter WordPress.
 * 
 * Flutter WordPress is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Flutter WordPress is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Flutter WordPress.  If not, see <https://www.gnu.org/licenses/>.
 * 
 * @license GPL-3.0-or-later <https://spdx.org/licenses/GPL-3.0-or-later.html>
 */

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/posts.dart';
import '../../domain/error/exceptions.dart';
import '../../domain/error/failures.dart';
import '../../domain/repositories/wp_repository.dart';
import '../datasources/wp_remote_data_source.dart';

@LazySingleton(as: WpRepository)
class WpRepositoryImpl implements WpRepository {
  final WpRemoteDataSource _wpRemoteDataSource;

  WpRepositoryImpl(
    this._wpRemoteDataSource,
  );

  @override
  Future<Either<Failure, Posts>> getPosts({
    String? search,
    List<String>? notIn,
    List<String>? authorIn,
    List<String>? categoryIn,
    List<String>? categoryNotIn,
    List<String>? tagIn,
    List<String>? tagNotIn,
    int? first,
    String? after,
    int? last,
    String? before,
    required bool forceRefresh,
  }) async {
    try {
      final Posts posts = await _wpRemoteDataSource.getPosts(
        search: search,
        notIn: notIn,
        authorIn: authorIn,
        categoryIn: categoryIn,
        categoryNotIn: categoryNotIn,
        tagIn: tagIn,
        tagNotIn: tagNotIn,
        first: first,
        after: after,
        last: last,
        before: before,
        forceRefresh: forceRefresh,
      );

      return Right(posts);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }
}
