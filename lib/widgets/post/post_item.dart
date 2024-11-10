import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:relative_time/relative_time.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/types/post.dart';
import 'package:surface/widgets/account/account_image.dart';
import 'package:surface/widgets/attachment/attachment_list.dart';
import 'package:surface/widgets/markdown_content.dart';
import 'package:gap/gap.dart';

class PostItem extends StatelessWidget {
  final SnPost data;
  const PostItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostContentHeader(data: data),
        _PostContentBody(data: data.body).padding(horizontal: 16, bottom: 6),
        if (data.preload?.attachments?.isNotEmpty ?? true)
          AttachmentList(data: data.preload!.attachments!, bordered: true),
      ],
    );
  }
}

class _PostContentHeader extends StatelessWidget {
  final SnPost data;
  const _PostContentHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AccountImage(content: data.publisher.avatar),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.publisher.nick).bold(),
              Row(
                children: [
                  Text('@${data.publisher.name}').fontSize(13),
                  const Gap(4),
                  Text(RelativeTime(context).format(data.publishedAt))
                      .fontSize(13),
                ],
              ).opacity(0.8),
            ],
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Symbols.more_horiz),
          style: const ButtonStyle(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.edit),
                  const Gap(16),
                  Text('edit').tr(),
                ],
              ),
              onTap: () {
                GoRouter.of(context).pushNamed(
                  'postEditor',
                  pathParameters: {'mode': data.typePlural},
                  queryParameters: {'editing': data.id.toString()},
                );
              },
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.delete),
                  const Gap(16),
                  Text('delete').tr(),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: Row(
                children: [
                  const Icon(Symbols.flag),
                  const Gap(16),
                  Text('report').tr(),
                ],
              ),
            ),
          ],
        ),
      ],
    ).padding(horizontal: 12, vertical: 8);
  }
}

class _PostContentBody extends StatelessWidget {
  final dynamic data;
  const _PostContentBody({this.data});

  @override
  Widget build(BuildContext context) {
    if (data['content'] == null) return const SizedBox.shrink();
    return MarkdownTextContent(content: data['content']);
  }
}
