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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nil/nil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/config/config.dart';
import '../../../../core/entities/post.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/types/post_id_type.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../providers.dart';
import '../notifier/single_post_state.dart';
import '../widgets/html_content.dart';
import '../widgets/related_posts.dart';

class SinglePost extends ConsumerStatefulWidget {
  final String id;
  final PostIdType idType;

  const SinglePost({
    required this.id,
    required this.idType,
    Key? key,
  }) : super(key: key);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends ConsumerState<SinglePost> {
  YoutubePlayerController? _playerController;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(singlePostProvider.notifier).fetchPost(
              widget.id,
              widget.idType,
            );
      },
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _playerController?.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _playerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final SinglePostState state = ref.watch(singlePostProvider);

        if (state is SinglePostLoading) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SinglePostLoaded) {
          ref.read(savedPostProvider.notifier).checkPost(state.post.id);

          if (state.post.video != '') {
            _playerController = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(state.post.video)!,
              flags: const YoutubePlayerFlags(
                loop: true,
              ),
            );
            return YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _playerController!,
              ),
              builder: (context, player) => buildContent(
                post: state.post,
                context: context,
                player: player,
              ),
            );
          } else {
            return buildContent(
              post: state.post,
              context: context,
            );
          }
        } else if (state is SinglePostError) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: ErrorIndicator(
              message: state.message,
              image: 'assets/img/error.png',
              onTryAgain: () {
                ref.read(singlePostProvider.notifier).fetchPost(
                      widget.id,
                      widget.idType,
                    );
              },
            ),
          );
        } else {
          return const Nil();
        }
      },
    );
  }

  Widget buildContent({
    required BuildContext context,
    required Post post,
    Widget? player,
  }) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder(),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final savedPostState = ref.watch(savedPostProvider);

          return SpeedDial(
            elevation: 0,
            spacing: 3,
            spaceBetweenChildren: 2,
            icon: Icons.menu,
            activeIcon: Icons.close,
            renderOverlay: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            children: <SpeedDialChild>[
              SpeedDialChild(
                elevation: 0,
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () => Share.share(
                  '${post.title}\nhttps://${CONFIG.hostName}${post.slug}',
                ),
                child: const Icon(
                  Icons.share,
                ),
              ),
              SpeedDialChild(
                elevation: 0,
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () {
                  if (savedPostState) {
                    ref.read(savedPostProvider.notifier).deletePost(
                          post.id,
                        );
                  } else {
                    ref.read(savedPostProvider.notifier).createPost(
                          PostModel(
                            id: post.id,
                            date: post.date,
                            slug: post.slug,
                            title: post.title,
                            content: '',
                            image: post.image,
                            video: post.video,
                            author: post.author,
                            categories: post.categories,
                            tags: const [],
                          ),
                        );
                  }
                },
                child: Icon(
                  savedPostState
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                ),
              ),
            ],
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: post.video != ''
                    ? player
                    : CachedNetworkImage(
                        imageUrl: post.image,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/placeholder.png',
                          fit: BoxFit.fitWidth,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Text(
                  post.categories[0].name,
                  style: Theme.of(context).primaryTextTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      post.author.avatar,
                    ),
                  ),
                  title: Text(
                    post.author.name,
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context).dateFormat(post.date),
                  ),
                ),
              ),
              HtmlContent(
                data: post.content,
              ),
              RelatedPosts(
                postId: post.id,
                categoryId: post.categories[0].id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
