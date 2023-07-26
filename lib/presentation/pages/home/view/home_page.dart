import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:choose_app/core/core.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/pages/home/home.dart';
import 'package:choose_app/presentation/theme/utils.dart';
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
          create: (_) => getIt<HomeBloc>()..init(locale: context.locale),
          child: this,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeBloc, HomeState>(
        listenWhen: _listenWhen,
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) => Stack(
          children: [
            Column(
              children: [
                const _ChoiceTextField(),
                Text(
                  context.l10n.general__or.toUpperCase(),
                  style: context.textTheme.bold.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.all(smallSize),
                  child: Card(
                    child: ListTile(
                      title: Text(context.l10n.home__select_from_list),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => _onPressedShowModal(context),
                    ),
                  ),
                ),
                const Spacer(),
                const _SelectedChoicesView(),
                const Spacer(),
                const _ChooseButton(),
              ],
            ),
            if (state is HomeSuccessState && state.status.isPending)
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: homePageBlurValue,
                  sigmaY: homePageBlurValue,
                ),
                child: const Center(child: LoadingCard()),
              ),
          ],
        ),
      );

  bool _buildWhen(HomeState previous, HomeState current) =>
      previous is HomeSuccessState &&
      current is HomeSuccessState &&
      previous.status != current.status;

  bool _listenWhen(HomeState previous, HomeState current) =>
      previous is HomeSuccessState &&
      current is HomeSuccessState &&
      current.selectedChoice != null &&
      previous.selectedChoice != current.selectedChoice;

  void _listener(BuildContext context, HomeState state) {
    if (state is! HomeSuccessState) return;

    final selectedChoice = state.selectedChoice;

    if (selectedChoice == null) return;

    final homeBloc = context.read<HomeBloc>();

    showDialog<void>(
      context: context,
      builder: (context) => BlocProvider.value(
        value: homeBloc,
        child: DrawResultDialog(
          choiceEntity: selectedChoice,
          suggestedPlace: state.suggestedPlace,
          userLocation: state.userLocation,
        ),
      ),
      barrierDismissible: false,
    );
  }

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
