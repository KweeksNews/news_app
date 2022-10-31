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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/entities/post.dart';
import '../../../../core/entities/state_exception.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/types/state_exception_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/post_list_tile.dart';
import '../../../../core/widgets/post_list_tile_loading.dart';
import '../../../../providers.dart';
import '../notifier/notifier.dart';

class SavedPosts extends ConsumerStatefulWidget {
  const SavedPosts({
    super.key,
  });

  @override
  ConsumerState<SavedPosts> createState() => SavedPostsPageState();
}

class SavedPostsPageState extends ConsumerState<SavedPosts> {
  late final PagingController<int, Post> _pagingController;
  bool _forceRefresh = false;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(
      firstPageKey: 0,
    );

    _pagingController.addPageRequestListener(
      (pageKey) {
        ref.read(savedPostsProvider.notifier).fetchPage(
              pageKey: pageKey,
              fetched: _pagingController.itemList?.length ?? 0,
              forceRefresh: _forceRefresh,
            );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  void refresh({
    bool forceRefresh = false,
  }) {
    _forceRefresh = forceRefresh;

    _pagingController.refresh();

    if (forceRefresh) {
      _forceRefresh = false;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.listen<SavedPostsState>(
      savedPostsProvider,
      (previousState, newState) {
        if (newState is SavedPostsAppend) {
          _pagingController.appendPage(newState.posts, newState.nextPageKey);
        } else if (newState is SavedPostsAppendLast) {
          _pagingController.appendLastPage(newState.posts);
        } else if (newState is SavedPostsException) {
          if (newState.type == StateExceptionType.failedToLoadData) {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorFailedToLoadData,
              image: 'assets/img/error.png',
            );
          } else {
            _pagingController.error = StateException(
              message: AppLocalizations.of(context).errorGeneric,
              image: 'assets/img/error.png',
            );
          }
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context).pageSavedPostsTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => refresh(forceRefresh: true),
            ),
            child: PagedListView<int, Post>(
              padding: const EdgeInsets.only(left: 15, right: 15),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                noItemsFoundIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    message: AppLocalizations.of(context).errorNoSavedPosts,
                    image: 'assets/img/no_data.png',
                  );
                },
                firstPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: List.generate(
                      5,
                      (index) {
                        return const PostListTileLoading(
                          margin: EdgeInsets.only(top: 15),
                        );
                      },
                    ),
                  );
                },
                itemBuilder: (context, post, index) {
                  return PostListTile(
                    post: post,
                    margin: const EdgeInsets.only(top: 15),
                    onTap: () {
                      context.push('/posts/${post.slug}');
                    },
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    message: _pagingController.error.message as String,
                    image: _pagingController.error.image as String,
                    onTryAgain: () {
                      refresh();
                    },
                  );
                },
                newPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: List.generate(
                      5,
                      (index) {
                        return const PostListTileLoading(
                          margin: EdgeInsets.only(top: 15),
                        );
                      },
                    ),
                  );
                },
                newPageErrorIndicatorBuilder: (context) {
                  return ErrorIndicator(
                    margin: const EdgeInsets.only(top: 15),
                    message: _pagingController.error.message as String,
                    image: _pagingController.error.image as String,
                    onTryAgain: () {
                      _pagingController.retryLastFailedRequest();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
