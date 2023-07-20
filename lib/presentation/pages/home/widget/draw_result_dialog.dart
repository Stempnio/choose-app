import 'package:auto_route/auto_route.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/domain/model/places/coordinates_entity.dart';
import 'package:choose_app/domain/model/places/place_entity.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/pages/home/bloc/bloc.dart';
import 'package:choose_app/presentation/theme/theme.dart';
import 'package:choose_app/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawResultDialog extends StatelessWidget {
  const DrawResultDialog({
    required this.choiceEntity,
    this.suggestedPlace,
    this.userLocation,
    super.key,
  });

  final ChoiceEntity choiceEntity;
  final PlaceEntity? suggestedPlace;
  final CoordinatesEntity? userLocation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: smallSize,
          vertical: mediumSize,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.home__draw_result.toUpperCase(),
              style: context.textTheme.bold.headlineSmall?.copyWith(
                color: Theme.of(context).disabledColor,
              ),
            ),
            VSpace.medium(),
            Text(
              choiceEntity.name,
              style: context.textTheme.bold.headlineLarge,
            ),
            VSpace.small(),
            const Divider(),
            Text('Rekomendowane miejsce'),
            VSpace.large(),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => _onPressedClose(context),
                child: Text(context.l10n.general__close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedClose(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.choicesReset());
    context.router.pop();
  }
}
