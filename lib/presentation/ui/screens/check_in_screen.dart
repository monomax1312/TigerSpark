import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/check_in.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../utils/locale_helpers.dart';
import '../../bloc/check_in/check_in_bloc.dart';
import '../../bloc/check_in/check_in_event.dart';
import '../../bloc/check_in/check_in_state.dart';
import '../widgets/tiger_mascot.dart';
import '../widgets/tiger_spark.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> with SingleTickerProviderStateMixin {
  EnergyLevel _energy = EnergyLevel.medium;
  MoodState _mood = MoodState.calm;
  FocusLevel _focus = FocusLevel.medium;
  bool _showSpark = false;
  CheckInDraft? _pendingDraft;
  late AnimationController _bounceController;
  late Animation<double> _bounceScale;

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _bounceScale = Tween<double>(begin: 1, end: 0.96).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
    context.read<CheckInBloc>().add(const CheckInScreenOpened());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckInBloc, CheckInState>(
      listener: (context, state) {
        if (state is CheckInSuccess) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.checkInDoneRemembered),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppTheme.orangePrimary,
              duration: const Duration(milliseconds: 2200),
            ),
          );
          Future.delayed(const Duration(milliseconds: 800), () {
            if (context.mounted) context.go('/');
          });
        }
      },
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final submitting = state is CheckInSubmitting;
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            child: Column(
              children: [
                const TigerMascot(size: 90, showGlow: true),
                const SizedBox(height: 8),
                Text(
                  l10n.checkInTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.checkInSubtitleShort,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                _Section(
                  title: '⚡ ${l10n.sectionEnergy}',
                  hint: l10n.hintEnergy,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      final level = EnergyLevel.values[i];
                      final selected = _energy == level;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () => setState(() => _energy = level),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppTheme.orangePrimary
                                  : AppTheme.yellowClarity.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: AppTheme.orangePrimary.withValues(alpha: 0.45),
                                        blurRadius: 14,
                                        spreadRadius: -2,
                                      ),
                                      BoxShadow(
                                        color: AppTheme.yellowClarity.withValues(alpha: 0.35),
                                        blurRadius: 8,
                                        spreadRadius: -4,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: selected ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                _Section(
                  title: '😌 ${l10n.sectionMood}',
                  hint: l10n.hintState,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: MoodState.values.map((mood) {
                      final selected = _mood == mood;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _mood = mood),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppTheme.orangePrimary.withValues(alpha: 0.2)
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected ? AppTheme.orangePrimary : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              localizedMood(l10n, mood),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selected ? AppTheme.orangePrimary : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                _Section(
                  title: '🧠 ${l10n.sectionFocus}',
                  hint: l10n.hintFocus,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: FocusLevel.values.map((focus) {
                      final selected = _focus == focus;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () => setState(() => _focus = focus),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppTheme.yellowClarity.withValues(alpha: 0.5)
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected ? AppTheme.yellowClarity : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              localizedFocus(l10n, focus),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: selected ? AppTheme.textPrimary : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
                ScaleTransition(
                  scale: _bounceScale,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submitting || _showSpark
                          ? null
                          : () async {
                              final draft = CheckInDraft(
                                energy: _energy,
                                mood: _mood,
                                focus: _focus,
                              );
                              _bounceController.forward();
                              await Future<void>.delayed(const Duration(milliseconds: 80));
                              _bounceController.reverse();
                              await Future<void>.delayed(const Duration(milliseconds: 100));
                              if (!mounted) return;
                              setState(() {
                                _showSpark = true;
                                _pendingDraft = draft;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: AppTheme.orangePrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: submitting
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(l10n.done),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
            if (_showSpark && _pendingDraft != null)
              Positioned.fill(
                child: TigerSparkOverlay(
                  duration: const Duration(milliseconds: 350),
                  onComplete: () {
                    if (!mounted || _pendingDraft == null) return;
                    context.read<CheckInBloc>().add(
                          CheckInSubmitted(_pendingDraft!),
                        );
                    setState(() {
                      _showSpark = false;
                      _pendingDraft = null;
                    });
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, this.hint, required this.child});

  final String title;
  final String? hint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
        ),
        if (hint != null) ...[
          const SizedBox(height: 4),
          Text(
            hint!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
