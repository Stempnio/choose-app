import 'package:auto_route/auto_route.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/l10n/l10n.dart';
import 'package:choose_app/presentation/constants/dimensions.dart';
import 'package:choose_app/presentation/constants/durations.dart';
import 'package:choose_app/presentation/constants/misc.dart';
import 'package:choose_app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:choose_app/presentation/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ChoiceInputPage extends HookWidget implements AutoRouteWrapper {
  const ChoiceInputPage({required this.homeBloc, super.key});

  final HomeBloc homeBloc;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider.value(
        value: homeBloc,
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final choice = useState(ChoiceEntity.empty());

    useEffect(
      () {
        Future.delayed(
          showKeyboardDelay,
          focusNode.requestFocus,
        );
        return null;
      },
      const [],
    );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(extraSmallSize),
            child: Column(
              children: [
                Hero(
                  tag: homeTextFieldTag,
                  child: Material(
                    child: TextField(
                      focusNode: focusNode,
                      onChanged: (value) =>
                          choice.value = choice.value.copyWith(name: value),
                      decoration: InputDecoration(
                        hintText: context.l10n.home__enter_your_choice,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () => context.router.pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                    HSpace.medium(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onPressedAdd(
                          context,
                          choice: choice.value,
                        ),
                        child: Text(context.l10n.general__add),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedAdd(
    BuildContext context, {
    required ChoiceEntity choice,
  }) {
    if (choice.name.isEmpty) return;

    context.router.pop();
    Future.delayed(
      addChoiceDelay,
      () => context.read<HomeBloc>().add(HomeEvent.choiceAdded(choice)),
    );
  }
}
