import 'package:flutter/material.dart';
import 'package:flutter_provider101/core/theme/app_palette.dart';
import 'package:flutter_provider101/core/utils/calculate_reading_time.dart';
import 'package:flutter_provider101/core/utils/format_date.dart';

import 'package:flutter_provider101/features/blog/domain/entities/blog.dart';
import 'package:gap/gap.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );
  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(5),
                Text(
                  '${formatDateBydMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppPalette.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                  ),
                ),
                const Gap(20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
