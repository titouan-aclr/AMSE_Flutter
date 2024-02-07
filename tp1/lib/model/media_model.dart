class MediaModel {
  final String title;
  final int year;
  final String artist;
  final String imageUrl;

  const MediaModel(
      {required this.title,
      required this.year,
      required this.artist,
      required this.imageUrl});
}

const films = [
  MediaModel(
    title: "The Game",
    year: 1997,
    artist: "David Fincher",
    imageUrl:
        "https://m.media-amazon.com/images/S/pv-target-images/faf34e5a9231d9ab121848f46561a0cc8e87ee94a1fc94f0a808f81fcb080214.jpg",
  ),
  MediaModel(
    title: "Shutter Island",
    year: 2010,
    artist: "Martin Scorcese",
    imageUrl:
        "https://m.media-amazon.com/images/I/81FNja+9-iL._AC_UF1000,1000_QL80_.jpg",
  ),
  MediaModel(
    title: "Cypher",
    year: 2003,
    artist: "Vincenzo Natali",
    imageUrl:
        "https://m.media-amazon.com/images/I/614m6RP5sIL._AC_UF1000,1000_QL80_.jpg",
  ),
  MediaModel(
    title: "Inception",
    year: 2010,
    artist: "Christopher Nolan",
    imageUrl:
        "https://m.media-amazon.com/images/I/91Rc8cAmnAL._AC_UF1000,1000_QL80_.jpg",
  ),
];

const series = [
  MediaModel(
    title: "Game of Thrones",
    year: 2011,
    artist: "David Benioff",
    imageUrl:
        "https://m.media-amazon.com/images/I/71P+4DslKmL._AC_UF1000,1000_QL80_.jpg",
  ),
  MediaModel(
    title: "Friends",
    year: 1994,
    artist: "Marta Kauffman",
    imageUrl:
        "https://m.media-amazon.com/images/I/81kL7SpTBjL._AC_UF1000,1000_QL80_.jpg",
  ),
  MediaModel(
    title: "The Office",
    year: 2005,
    artist: "Greg Daniels",
    imageUrl:
        "https://m.media-amazon.com/images/M/MV5BMDNkOTE4NDQtMTNmYi00MWE0LWE4ZTktYTc0NzhhNWIzNzJiXkEyXkFqcGdeQXVyMzQ2MDI5NjU@._V1_.jpg",
  ),
  MediaModel(
    title: "The Big Bang Theory",
    year: 2007,
    artist: "Mark Cendrowski",
    imageUrl:
        "https://m.media-amazon.com/images/I/717Se+lZiOL._AC_UF1000,1000_QL80_.jpg",
  ),
];

const musics = [
  MediaModel(
    title: "Let It Be",
    year: 1970,
    artist: "The Beatles",
    imageUrl: "https://upload.wikimedia.org/wikipedia/en/2/25/LetItBe.jpg",
  ),
  MediaModel(
    title: "Natural",
    year: 2018,
    artist: "Imagine Dragons",
    imageUrl:
        "https://cdns-images.dzcdn.net/images/cover/974997a0db8d1d0c2de1ebde4275997f/500x500.jpg",
  ),
  MediaModel(
    title: "Umbrella",
    year: 2007,
    artist: "Rihanna",
    imageUrl:
        "https://cdns-images.dzcdn.net/images/cover/974997a0db8d1d0c2de1ebde4275997f/500x500.jpg",
  ),
  MediaModel(
    title: "Paint it, Black",
    year: 1966,
    artist: "The Rolling Stones",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/en/5/58/Paint_It_Black_UK_sleeve.jpg",
  ),
];
