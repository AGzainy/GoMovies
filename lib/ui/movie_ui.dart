import 'package:go_movies/model/movie.dart';
import 'package:go_movies/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
Color _blue = HexColor("#011f62");
Color _blue2 = HexColor("#000020");
class MovieDetailsThumbnail extends StatelessWidget {
  final String? thumbnail;
  final String? trailer;

  const MovieDetailsThumbnail({Key? key, this.thumbnail,this.trailer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30,bottom: 40),
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(thumbnail!), fit: BoxFit.fitHeight)),
            ),
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Link(
                  uri: Uri.tryParse(trailer!),
                  target: LinkTarget.defaultTarget,
                  builder: (context, followLink) {
                    return IconButton(
                      onPressed: followLink,
                      icon: Container(
                          child: Icon(
                            Icons.play_circle_fill_outlined,
                            size: 80,
                            color: Colors.white,
                          )),
                    );
                  }),
            ),
            //Icon(Icons.play_circle_fill_outlined,size: 100,color: Colors.white,)
          ],
        ),
        Container(
          decoration: BoxDecoration(
            //gradient: RadialGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              gradient: LinearGradient(colors: [
                _blue2,
                _blue2,
                Color(0x00f5f5f5),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          //height: 400, //for radialGradient
          height: 150,
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie? movie;

  const MovieDetailsHeaderWithPoster({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie!.poster),
          SizedBox(
            width: 16,
          ),
          VirticalLine(),
          Expanded(child: MovieDetailsHeader(movie: movie))
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie? movie;

  const MovieDetailsHeader({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(
            "${movie!.year}        ${movie!.type}",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: _blue2, fontSize: 18),
          ),
        ),
        Text(
          movie!.title,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white70),
        ),
        Text.rich(TextSpan(
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.white70),
            children: [
              TextSpan(text: movie!.plot),
            ]))
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String? poster;

  const MoviePoster({Key? key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(poster ??
                      "https://media.istockphoto.com/vectors/star-icon-vector-id1129712692?k=20&m=1129712692&s=612x612&w=0&h=LHyR3dyiTXewDgGh6HGL4Hvky1s4veeEkr3VE05N5ww="),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class MovieDetailsStory extends StatelessWidget {
  final Movie? movie;

  const MovieDetailsStory({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text("My Story",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white70,
                    fontWeight: FontWeight.w800)),
          ),
          MovieField(field: "It goes like:", value: movie!.story)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String? field;
  final String? value;

  const MovieField({Key? key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(field ?? "it goes like:",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white70,
            )),
      ),
      Text(
        value ?? "missing story",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white70,
          fontFamily: "PatrickHand",
        ),
      )
    ]);
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.white38,
      ),
    );
  }
}

class VirticalLine extends StatelessWidget {
  const VirticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8,top: 15),
      width: 0.5,
      height: 200,
      color: Colors.black,
    );
  }
}

class MovieImages extends StatelessWidget {
  final List? posters;

  const MovieImages({Key? key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "movie images".toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white70),
          ),
        ),
        Container(
          height: 400,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: 8,
            ),
            itemCount: posters!.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters![index]),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        )
      ],
    );
  }
}