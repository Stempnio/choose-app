import 'package:carousel_slider/carousel_slider.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/presentation.dart';
import 'package:choose_app/presentation/utils/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      previous.userChoices.length < current.userChoices.length;

  void _listener(_, HomeState state) => state.mapOrNull(
        success: (state) => carouselController.animateToPage(
          state.userChoices.length - 1,
        ),
      );

  List<Widget> _mapChoices(List<ChoiceEntity> choices) => choices
      .map((choice) => _ChoiceSliderCard(choice, carouselController))
      .toList();
}

class _ChoiceSliderCard extends HookWidget {
  _ChoiceSliderCard(this.choice, this.carouselController)
      : super(key: ValueKey(choice.id));

  final ChoiceEntity choice;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController();

    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusMedium,
      ),
      position: PopupMenuPosition.over,
      offset: const Offset(15, -15),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<void>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.home__delete),
              const Icon(Icons.delete),
            ],
          ),
          onTap: () => _onTapDelete(
            context,
            animController: animController,
          ),
        ),
      ],
      child: Animate(
        controller: animController,
        effects: const [FadeEffect(begin: 0, end: 1)],
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                choice.name,
                style: context.textTheme.bold.headlineSmall,
              ),
              const Divider(),
              Text(
                choice.type.str(context),
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapDelete(
    BuildContext context, {
    required AnimationController animController,
  }) async {
    await carouselController.previousPage();
    await animController.reverse();
    if (context.mounted) {
      context.read<HomeBloc>().add(HomeEvent.choiceRemoved(choice));
    }
  }
}
