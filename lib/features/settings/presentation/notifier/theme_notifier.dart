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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/presentation/l10n/generated/l10n.dart';
import '../../domain/usecases/get_theme.dart';
import '../../domain/usecases/set_theme.dart';

@injectable
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final GlobalKey<NavigatorState> _rootNavigatorKey;
  final GetTheme _getTheme;
  final SetTheme _setTheme;

  ThemeNotifier(
    @factoryParam this._rootNavigatorKey,
    this._getTheme,
    this._setTheme,
  ) : super(ThemeMode.system);

  Future<void> get() async {
    final failureOrThemeMode = await _getTheme();

    if (mounted) {
      failureOrThemeMode.fold(
        // TODO implement failure
        (failure) => null,
        (themeMode) {
          state = themeMode;
        },
      );
    }
  }

  Future<void> set({
    required ThemeMode mode,
  }) async {
    final failureOrThemeMode = await _setTheme(
      mode: mode,
    );

    if (mounted) {
      failureOrThemeMode.fold(
        (failure) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(_rootNavigatorKey.currentContext!)
                .errorFailedToChangeTheme,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        },
        (themeMode) {
          state = themeMode;
        },
      );
    }
  }
}
