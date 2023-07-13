import 'package:carousel_slider/carousel_slider.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoicesSlider extends StatefulWidget {
  const ChoicesSlider({super.key});

  @override
  State<ChoicesSlider> createState() => _ChoicesSliderState();
}

class _ChoicesSliderState extends State<ChoicesSlider> {
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) => state.maybeMap(
          success: (state) => CarouselSlider(
            carouselController: carouselController,
            items: _mapChoices(state.userChoices),
            options: CarouselOptions(
              height: choicesSliderHeight,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
            ),
          ),
          orElse: SizedBox.shrink,
        ),
        listenWhen: _listenWhen,
        listener: _listener,
      );

  bool _listenWhen(HomeState previous, HomeState current) =>
      previous is HomeSuccessState &&
      current is HomeSuccessState &&
      previous.userChoices.length != current.userChoices.length;

  void _listener(_, HomeState state) => state.mapOrNull(
        success: (state) => carouselController.animateToPage(
          state.userChoices.length - 1,
        ),
      );

  List<Widget> _mapChoices(List<ChoiceEntity> choices) =>
      choices.map(_ChoiceSliderCard.new).toList();
}

class _ChoiceSliderCard extends StatelessWidget {
  const _ChoiceSliderCard(this.choice);

  final ChoiceEntity choice;

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              const Spacer(),
              Text(
                choice.name,
                style: context.textTheme.bold.headlineSmall,
              ),
              const Spacer(),
              const Divider(),
              Text(
                choice.type.str(context),
                style: context.textTheme.titleMedium,
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
