import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../bloc/rating/rating_bloc.dart';
import '/injection_container.dart' as di;

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<RatingBloc>(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(builder: (context, state) {
      return Scaffold(
          body: Center(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: state.allServices
                    .map((item) => RatingBar.builder(
                          allowHalfRating: false,
                          itemSize: 18,
                          initialRating: item.ratingGivenByMe != null
                              ? item.ratingGivenByMe!.toDouble()
                              : 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          textDirection: TextDirection.rtl,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          updateOnDrag: true,
                          onRatingUpdate: (newRating) {
                            setState(() {
                              BlocProvider.of<RatingBloc>(context).add(
                                  RatingEventButton(
                                      serviceId: item.id,
                                      rating: newRating.toInt()));
                            });
                          },
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ));
    });
  }
}
