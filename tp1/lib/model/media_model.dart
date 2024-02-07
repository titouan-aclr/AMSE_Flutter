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
        "https://fr.web.img3.acsta.net/c_310_420/medias/nmedia/00/02/21/28/19163163.jpg",
  ),
  MediaModel(
    title: "Shutter Island",
    year: 2010,
    artist: "Martin Scorcese",
    imageUrl:
        "https://fr.web.img4.acsta.net/medias/nmedia/18/69/96/84/19151192.jpg",
  ),
  MediaModel(
    title: "Cypher",
    year: 2003,
    artist: "Vincenzo Natali",
    imageUrl:
        "https://fr.web.img6.acsta.net/medias/nmedia/00/02/53/17/affiche2.jpg",
  ),
  MediaModel(
    title: "Inception",
    year: 2010,
    artist: "Christopher Nolan",
    imageUrl:
        "https://fr.web.img2.acsta.net/medias/nmedia/18/72/34/14/19476654.jpg",
  ),
];

const series = [
  MediaModel(
    title: "Game of Thrones",
    year: 2011,
    artist: "David Benioff",
    imageUrl:
        "https://fr.web.img3.acsta.net/c_310_420/pictures/23/01/03/14/13/0717778.jpg",
  ),
  MediaModel(
    title: "Friends",
    year: 1994,
    artist: "Marta Kauffman",
    imageUrl:
        "https://fr.web.img2.acsta.net/pictures/18/11/13/14/05/2764761.jpg",
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
        "https://fr.web.img5.acsta.net/pictures/18/11/06/15/36/0408812.jpg",
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
