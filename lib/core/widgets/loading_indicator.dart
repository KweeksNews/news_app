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
import 'package:nil/nil.dart';
import 'package:shimmer/shimmer.dart';

import '../types/loading_type.dart';

class LoadingIndicator extends StatelessWidget {
  final int count;
  final LoadingType type;

  const LoadingIndicator({
    required this.count,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        switch (type) {
          case LoadingType.postTile:
            return Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.primary.withAlpha(20),
              highlightColor:
                  Theme.of(context).colorScheme.surface.withAlpha(20),
              period: const Duration(milliseconds: 1000),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 150,
                  maxHeight: 150,
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.fromLTRB(30, 20, 15, 5),
                      child: const SizedBox.expand(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                      child: const SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case LoadingType.postBox:
            // TODO add post box loading indicator
            return const Nil();
        }
      }),
    );
  }
}
