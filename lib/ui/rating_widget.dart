import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  RatingWidget({required this.rating, required this.totalVoting});

  final double rating;
  final int totalVoting;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildStars(rating),
          Text(
            "$totalVoting Reviews",
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getIconFromRating(rating - 0),
            _getIconFromRating(rating - 1),
            _getIconFromRating(rating - 2),
            _getIconFromRating(rating - 3),
            _getIconFromRating(rating - 4)
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "$rating/5.0",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Icon _getIconFromRating(double rating) {
    if (rating >= 1) {
      return Icon(
        Icons.star,
        color: Colors.red,
      );
    }
    if (rating > 0.0 && rating < 1) {
      return Icon(
        Icons.star_half,
        color: Colors.red,
      );
    }
    return Icon(
      Icons.star_border,
      color: Colors.red,
    );
  }
}
