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

import '../../../../core/data/datasources/saved_posts_local_data_source.dart';
import '../../../../core/data/datasources/wp_remote_data_source.dart';
import '../../../../core/data/models/post_model.dart';
import '../../../../core/domain/entities/post.dart';
import '../../../../core/domain/enums/post_id_type.dart';
import '../../../../core/domain/error/exceptions.dart';
import '../../../../core/domain/error/failures.dart';
import '../../domain/repositories/single_post_repository.dart';

@LazySingleton(as: SinglePostRepository)
class SinglePostRepositoryImpl implements SinglePostRepository {
  final SavedPostsLocalDataSource _savedPostsLocalDataSource;
  final WpRemoteDataSource _wpRemoteDataSource;

  SinglePostRepositoryImpl(
    this._savedPostsLocalDataSource,
    this._wpRemoteDataSource,
  );

  @override
  Future<Either<Failure, bool>> checkPostSaveStatus({
    required int postId,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.checkPostSaveStatus(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addSavedPost({
    required Post post,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.createSavedPost(
        post: PostModel(
          id: post.id,
          date: post.date,
          slug: post.slug,
          title: post.title,
          content: post.content,
          image: post.image,
          video: post.video,
          author: post.author,
          categories: post.categories,
          tags: post.tags,
        ),
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteSavedPost({
    required int postId,
  }) async {
    try {
      return Right(await _savedPostsLocalDataSource.deleteSavedPost(
        postId: postId,
      ));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> getPost({
    required String id,
    required PostIdType idType,
    required bool forceRefresh,
  }) async {
    try {
      final Post post = await _wpRemoteDataSource.getPost(
        id: id,
        idType: idType.toString(),
        forceRefresh: forceRefresh,
      );

      return Right(post);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RequestException {
      return Left(RequestFailure());
    }
  }
}
