import 'package:flutter/material.dart';
import'classes.dart';

Center buildMovieCard1(BuildContext context, Movie movie, Function flipIsFavorite) {
  return Center(
      child: Container(
        width: 500,
        height: 220,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Stack(
            children:[ Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    movie.img!,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.categoryName,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 16,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.name,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.description,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 13,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(
                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite ? Colors.indigo : Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                      flipIsFavorite(movie);
                  },
                ),
              ),
        ],
        ),

        ),
      ),
    );
}