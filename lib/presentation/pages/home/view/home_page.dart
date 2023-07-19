import 'package:auto_route/auto_route.dart';
import 'package:choose_app/core/core.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/pages/home/bloc/bloc.dart';
import 'package:choose_app/presentation/pages/home/widget/choices_modal_sheet.dart';
import 'package:choose_app/presentation/pages/home/widget/choices_slider.dart';
import 'package:choose_app/presentation/theme/utils.dart';
import 'package:choose_app/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => SafeArea(
        child: BlocProvider(
          create: (_) => getIt<HomeBloc>(),
          child: this,
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const _ChoiceTextField(),
          Text(
            context.l10n.general__or.toUpperCase(),
            style: context.textTheme.bold.headlineSmall,
          ),
          VSpace.medium(),
          ElevatedButton(
            onPressed: () => _onPressedShowModal(context),
            child: Text(context.l10n.home__select_from_list),
          ),
          const Spacer(),
          const _SelectedChoicesView(),
          const Spacer(),
          const _ChooseButton(),
        ],
      );

  void _onPressedShowModal(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: homeBloc,
        child: const ChoicesModalSheet(),
      ),
    );
  }
}

class _ChoiceTextField extends StatelessWidget {
  const _ChoiceTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(largeSize),
      child: Hero(
        tag: homeTextFieldTag,
        child: Material(
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: context.l10n.home__enter_your_choice,
            ),
            onTap: () => _onTap(context),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    context.router.push(ChoiceInputRoute(homeBloc: homeBloc));
  }
}

class _SelectedChoicesView extends StatelessWidget {
  const _SelectedChoicesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state) {
          case HomeSuccessState(:final userChoices):
            return AnimatedSwitcher(
              duration: homeSwitchDuration,
              child: userChoices.isNotEmpty
                  ? const ChoicesSlider()
                  : const SizedBox.shrink(),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ChooseButton extends HookWidget {
  const _ChooseButton();

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController();
    final homeBloc = context.watch<HomeBloc>();

    final didSelectOptions = homeBloc.state.maybeMap(
      success: (state) => state.userChoices.isNotEmpty,
      orElse: () => false,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: smallSize,
        horizontal: largeSize,
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: didSelectOptions
              ? () => _onPressed(context, animController)
              : null,
          child: Animate(
            controller: animController,
            autoPlay: false,
            effects: const [ShakeEffect()],
            child: Text(
              didSelectOptions
                  ? context.l10n.home__choose
                  : context.l10n.home__select_choices_to_proceed,
              style: context.textTheme.bold.titleMedium,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed(
    BuildContext context,
    AnimationController controller,
  ) async {
    context.read<HomeBloc>().add(const ChoicesSubmitted());
    await controller.forward();
    controller.reset();
  }
}
