import 'package:flutter/material.dart';
import 'classes.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  final List<Cinema> cinemas;
  MovieDetailsPage({required this.movie, required this.cinemas});
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
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  movie.img!,
                  fit: BoxFit.contain, // Adjust how the image fills the space
                  width: 200, // Take up the available width
                  height: 200, // Let height adjust dynamically
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
                            fontSize: 18,
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
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(height: 20, thickness: 1, color: Theme.of(context).dividerColor),
                    Text(
                      'Cinema',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cinemas.length,
                      itemBuilder: (context, index) {
                        return _buildCinemaCard1(context, cinemas[index]);
                      },
                    ),
                    SizedBox(height: 8),
                    Divider(height: 20, thickness: 1, color: Theme.of(context).dividerColor),
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    SizedBox(height: 8),
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
                    ),/**/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildCinemaCard1(BuildContext context, Cinema c) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12,left: 12, top: 12),
                  child: Text(
                    c.name,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      //backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                    ),
                  ),
              ),
              SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 16,left: 12, top: 0,bottom: 10),
            child:ListView.builder(
                shrinkWrap: true,
                itemCount: c.tickets.length,
                itemBuilder: (context, index) {
                  return Text(
                      " starting from: ${c.tickets[index].start} to: ${c.tickets[index].end} price: ${c.tickets[index].price}",
                      style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                  height: 1.5,
                  )
                  );

                },
              ),
          ),

            ],
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