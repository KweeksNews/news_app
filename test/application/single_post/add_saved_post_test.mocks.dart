// Mocks generated by Mockito 5.3.2 from annotations
// in news/test/application/single_post/add_saved_post_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:news/domain/entities/post.dart' as _i6;
import 'package:news/domain/entities/posts.dart' as _i7;
import 'package:news/domain/error/failures.dart' as _i5;
import 'package:news/domain/repositories/shared/saved_posts_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SavedPostsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSavedPostsRepository extends _i1.Mock
    implements _i3.SavedPostsRepository {
  MockSavedPostsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> addSavedPost(
          {required _i6.Post? post}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addSavedPost,
          [],
          {#post: post},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
            _FakeEither_0<_i5.Failure, int>(
          this,
          Invocation.method(
            #addSavedPost,
            [],
            {#post: post},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, int>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Posts>> getSavedPosts({
    required int? postsCount,
    required int? pageKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSavedPosts,
          [],
          {
            #postsCount: postsCount,
            #pageKey: pageKey,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.Posts>>.value(
            _FakeEither_0<_i5.Failure, _i7.Posts>(
          this,
          Invocation.method(
            #getSavedPosts,
            [],
            {
              #postsCount: postsCount,
              #pageKey: pageKey,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.Posts>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> deleteSavedPost(
          {required int? postId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSavedPost,
          [],
          {#postId: postId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
            _FakeEither_0<_i5.Failure, int>(
          this,
          Invocation.method(
            #deleteSavedPost,
            [],
            {#postId: postId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, int>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> checkPostSaveStatus(
          {required int? postId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkPostSaveStatus,
          [],
          {#postId: postId},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #checkPostSaveStatus,
            [],
            {#postId: postId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}
