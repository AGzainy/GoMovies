import 'movie_ui.dart';
import 'package:go_movies/model/movie.dart';
import 'package:go_movies/hexcolor.dart';
import 'package:flutter/material.dart';



Color _blue = HexColor("#011f62");
Color _blue2 = HexColor("#000020");

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movieList = Movie.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text("JTU MOVIES",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        centerTitle: true,
        backgroundColor: _blue,
      ),
      backgroundColor: _blue,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Positioned(child: movieCard(movieList[index], context)),
              //i didn't use positioned
              Positioned(top: 13, child: movieImage(movieList[index].poster)),
            ]);
            // return Card(
            //   elevation: 4.5,
            //   margin: EdgeInsets.only(top: 8),
            //   color: Colors.white,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Container(
            //         width: 200,
            //           height: 200,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(movieList[index].poster),
            //             fit: BoxFit.cover
            //           ),
            //             borderRadius: BorderRadius.circular(19)
            //         ),
            //
            //       ),
            //     ),
            //     trailing: Text("..."),
            //     title: Text(movieList[index].title),
            //     subtitle: Text("${movieList[index].plot}"),
            //     onTap: (){
            //       Navigator.push(context,MaterialPageRoute(
            //           builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title,
            //           movie: movieList[index],)));
            //     },
            //   ),
            // );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 60),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Card(
            margin: EdgeInsets.only(top: 5, left: 9, right: 9, bottom: 5),
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, left: 40, right: 0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          //so it won't overflow
                            child: Text(
                              movie.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Text(
                          "Rating: ${movie.rating}/10",
                          style: TextStyle(color: _blue, fontSize: 13),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            child: Text(
                              "${movie.actors}",
                              style: mainTextStyle(),
                            )),
                        Text(
                          movie.type,
                          style: mainTextStyle(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(
                      movieName: movie.title, movie: movie)))
        });
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 10, color: Colors.white70);
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    );
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String? movieName;
  final Movie? movie;

  const MovieListViewDetails({Key? key, this.movieName, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text("JTU", style: TextStyle(color: Colors.white, fontSize: 25,)),
        backgroundColor: _blue,
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _blue2,
        ),
        child: ListView(
          //its better to always put things inside a listview.
          children: [
            MovieDetailsThumbnail(thumbnail: movie!.poster,trailer: movie!.trailer,),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              decoration: BoxDecoration(
                color: _blue,
                boxShadow: [
                  BoxShadow(
                    color: _blue,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                //border: Border.all(style: BorderStyle.solid),
                //borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child:
                MovieDetailsHeaderWithPoster(
                  movie: movie,
                ),),),
            Column(
                children:[
                  HorizontalLine(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: MovieDetailsStory(
                      movie: movie,
                    ),
                  ),
                  HorizontalLine(),
                ]
            ),


            MovieImages(
              posters: movie!.images,
            ),
            HorizontalLine()
          ],
        ),
      ),
      // body: Container(
      //   child: ElevatedButton(
      //     child: Text("Go Back  ${this.movieName}"),
      //     onPressed: (){
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
    );
  }
}

