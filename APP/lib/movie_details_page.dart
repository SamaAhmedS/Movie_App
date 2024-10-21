import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
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
          style:
              TextStyle(color: Theme.of(context).textTheme.titleLarge!.color),
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
                child: Image.asset(
                  movie.img!,
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(Icons.error,
                        color: Theme.of(context).colorScheme.error);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    SizedBox(height: 8),
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
                    Text(
                      movie.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(
                        height: 20,
                        thickness: 1,
                        color: Theme.of(context).dividerColor),
                    SizedBox(height: 16),
                    Text(
                      'Movie Trailer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    SizedBox(height: 16),
                    Trailer(trailerPath: movie.trailer_path),
                    SizedBox(height: 16),
                    Divider(
                        height: 20,
                        thickness: 1,
                        color: Theme.of(context).dividerColor),
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
                    Divider(
                        height: 20,
                        thickness: 1,
                        color: Theme.of(context).dividerColor),
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
                              return _buildCommentCard(
                                  context, movie.comments![index]);
                            },
                          )
                        : Center(
                            child: Text(
                              'No comments yet.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
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
                padding: EdgeInsets.only(right: 12, left: 12, top: 12),
                child: Text(
                  c.name,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding:
                    EdgeInsets.only(right: 16, left: 12, top: 0, bottom: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: c.tickets.length,
                  itemBuilder: (context, index) {
                    return Text(
                      " starting from: ${c.tickets[index].start} to: ${c.tickets[index].end} price: ${c.tickets[index].price}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        height: 1.5,
                      ),
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
                    backgroundColor:
                        Theme.of(context).cardColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  c.content,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor:
                        Theme.of(context).cardColor.withOpacity(0.7),
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

class Trailer extends StatefulWidget {
  final String trailerPath;

  Trailer({required this.trailerPath});

  @override
  _TrailerState createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  late VideoPlayerController _controller;
  bool _showControls = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.trailerPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _fastForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _rewind() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _controller
        .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
          _showControls
              ? Positioned(
                  bottom: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: _rewind,
                        iconSize: 50,
                        icon: Icon(Icons.fast_rewind, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        iconSize: 50,
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _fastForward,
                        iconSize: 50,
                        icon: Icon(Icons.fast_forward, color: Colors.white),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
