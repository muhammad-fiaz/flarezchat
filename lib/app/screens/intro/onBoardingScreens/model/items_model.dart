
class Chat {
  final String title;
  final String subtitle;

  Chat({
    required this.title,
    required this.subtitle,
  });
}

class Items {
  final String img;
  final String title;
  final String subTitle;
  final Chat chat;

  Items({
    required this.img,
    required this.title,
    required this.subTitle,
    required this.chat,
  });
}
// these are the onBoardingScreens Intro Contents
List<Items> listOfItems = [
  Items(
    img: "assets/images/intro/1.png",
    title: "Chat with your friends",
    subTitle:
    "Stay connected with your friends and\nfamily with our messaging app.",
    chat: Chat(
      title: "Best Friends",
      subtitle: "Chat with your best friends here.",
    ),
  ),
  Items(
    img: "assets/images/intro/2.png",
    title: "Join group chats",
    subTitle:
    "Find and join groups that share your\ninterests and chat with them.",
    chat: Chat(
      title: "Group Chats",
      subtitle: "Join groups that share your interests.",
    ),
  ),
  Items(
    img: "assets/images/intro/3.png",
    title: "Meet new people",
    subTitle: "Discover and chat with new people\naround the world.",
    chat: Chat(
      title: "New People",
      subtitle: "Discover and chat with new people.",
    ),
  ),
];
