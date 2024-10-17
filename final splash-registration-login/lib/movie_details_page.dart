import 'package:flutter/material.dart';
import 'classes.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  MovieDetailsPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name,
          style: TextStyle(color: Theme.of(context).textTheme.titleLarge!.color),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                movie.img!,
                fit: BoxFit.cover, // Adjust how the image fills the space
                width: 600, // Take up the available width
                height: 300, // Let height adjust dynamically
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Icon(Icons.error, color: Theme.of(context).colorScheme.error);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Movie Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.categoryName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Movie Description
                  Text(
                    movie.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Comments Section
                  Divider(height: 40, thickness: 1, color: Theme.of(context).dividerColor),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  SizedBox(height: 16),
                  movie.comments != null
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: movie.comments!.length,
                    itemBuilder: (context, index) {
                      return _buildCommentCard(context, movie.comments![index]);
                    },
                  )
                      : Center(
                    child: Text(
                      'No comments yet.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildCinemaCard(BuildContext context, Cinema c) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _buildCommentCard(BuildContext context, Comment c) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              DateFormat('yyyy-MM-dd HH:mm').format(c.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.username,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  c.content,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}