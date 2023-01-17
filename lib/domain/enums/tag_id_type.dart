// Copyright (c) 2021-2023 Ahmad Rulim
// Copyright (c) 2021-2023 KweeksNews Network
//
// This file is part of KweeksNews.
//
// SPDX-License-Identifier: GPL-3.0-or-later

enum TagIdType {
  databaseId('DATABASE_ID'),
  id('ID'),
  name('NAME'),
  slug('SLUG'),
  uri('URI');

  final String type;

  const TagIdType(
    this.type,
  );

  @override
  String toString() => type;
}
