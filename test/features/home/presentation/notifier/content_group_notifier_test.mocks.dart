// Mocks generated by Mockito 5.3.2 from annotations
// in kweeksnews_app/test/features/home/presentation/notifier/content_group_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:kweeksnews_app/core/domain/entities/posts.dart' as _i6;
import 'package:kweeksnews_app/core/domain/error/failures.dart' as _i5;
import 'package:kweeksnews_app/core/domain/usecases/get_posts.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [GetPosts].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPosts extends _i1.Mock implements _i3.GetPosts {
  MockGetPosts() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>> call({
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
    required bool? forceRefresh,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #search: search,
            #notIn: notIn,
            #authorIn: authorIn,
            #categoryIn: categoryIn,
            #categoryNotIn: categoryNotIn,
            #tagIn: tagIn,
            #tagNotIn: tagNotIn,
            #first: first,
            #after: after,
            #last: last,
            #before: before,
            #forceRefresh: forceRefresh,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>>.value(
            _FakeEither_0<_i5.Failure, _i6.Posts>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #search: search,
              #notIn: notIn,
              #authorIn: authorIn,
              #categoryIn: categoryIn,
              #categoryNotIn: categoryNotIn,
              #tagIn: tagIn,
              #tagNotIn: tagNotIn,
              #first: first,
              #after: after,
              #last: last,
              #before: before,
              #forceRefresh: forceRefresh,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Posts>>);
}
