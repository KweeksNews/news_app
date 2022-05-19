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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/types/state_exception_type.dart';
import '../../domain/usecases/get_saved_posts.dart';
import 'notifier.dart';

@injectable
class SavedPostsNotifier extends StateNotifier<SavedPostsState> {
  final GetSavedPosts _getSavedPosts;

  SavedPostsNotifier(
    this._getSavedPosts,
  ) : super(const SavedPostsLoading());

  Future<void> fetchPage({
    required int pageKey,
    required int fetched,
    bool forceRefresh = false,
  }) async {
    final failureOrPosts = await _getSavedPosts(
      pageKey: pageKey,
    );

    if (!mounted) {
      return;
    } else {
      failureOrPosts.fold(
        (failure) {
          state = const SavedPostsException(
            type: StateExceptionType.failedToLoadData,
          );
        },
        (postList) {
          if (fetched + postList.posts.length != postList.totalPosts!) {
            state = SavedPostsAppend(
              posts: postList.posts,
              nextPageKey: pageKey + 1,
            );
          } else {
            state = SavedPostsAppendLast(
              posts: postList.posts,
            );
          }
        },
      );
    }
  }
}
