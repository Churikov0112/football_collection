import 'dart:ui';

Color? ratingColor(int? rating) {
  if (rating == null) {
    return null;
  }

  if (rating >= 75) {
    return const Color(0xFF00AA00);
  } else if (rating >= 60) {
    return const Color.fromARGB(255, 250, 159, 0);
  } else if (rating >= 50) {
    return const Color.fromARGB(255, 255, 102, 0);
  } else {
    return const Color(0xFFDC143C);
  }
}
