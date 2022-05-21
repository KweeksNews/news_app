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

import '../../../../core/entities/post_list.dart';
import '../../../../core/entities/tag.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/types/tag_id_type.dart';

abstract class SingleTagRepository {
  Future<Either<Failure, Tag>> getTag({
    required String id,
    required TagIdType idType,
    required bool forceRefresh,
  });

  Future<Either<Failure, PostList>> getPosts({
    required List<String> tagIn,
    required int postsCount,
    required String pageKey,
    required bool forceRefresh,
  });
}
