import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kweeksnews_app/core/domain/error/failures.dart';
import 'package:kweeksnews_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:kweeksnews_app/features/settings/domain/usecases/get_theme.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_theme_test.mocks.dart';

@GenerateMocks([SettingsRepository])
void main() {
  late MockSettingsRepository mockSettingsRepository;
  late GetTheme usecase;

  const ThemeMode testTheme = ThemeMode.system;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    usecase = GetTheme(mockSettingsRepository);
  });

  test(
    'Should get locale from repository',
    () async {
      // Arrange
      when(
        mockSettingsRepository.getTheme(),
      ).thenAnswer(
        (_) async => const Right(testTheme),
      );

      // Act
      final result = await usecase();

      // Assert
      verify(
        mockSettingsRepository.getTheme(),
      );

      verifyNoMoreInteractions(
        mockSettingsRepository,
      );

      expect(
        result,
        const Right<Failure, ThemeMode>(testTheme),
      );
    },
  );
}
