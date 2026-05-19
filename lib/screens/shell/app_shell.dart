import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:go_router/go_router.dart';
import 'package:Echo/services/update_service/update_service.dart';

import '../../generated/l10n.dart';
import 'widgets/bottom_player.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('AppShell'));
  final StatefulNavigationShell navigationShell;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();
    UpdateService.autoCheck(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _applyWindowEffect();
  }

  void _applyWindowEffect() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      await flutter_acrylic.Window.setEffect(
        effect: flutter_acrylic.WindowEffect.acrylic,
        color: isDark ? const Color(0x1F000000) : const Color(0x1FFFFFFF),
        dark: isDark,
      );
    }
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final gradient = isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0C20), // Deep space indigo
              Color(0xFF15102A), // Dark purple tint
              Color(0xFF0A0812), // Deep black
            ],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF3E7E9), // Soft warm blush
              Color(0xFFE3EEFF), // Soft lavender blue
              Color(0xFFF5F5FA), // Pale off-white
            ],
          );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                if (screenWidth >= 450)
                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: NavigationRail(
                          extended: true,
                          backgroundColor: Colors.transparent,
                          groupAlignment: 0.0,
                          destinations: [
                            NavigationRailDestination(
                              selectedIcon: Icon(
                                CupertinoIcons.music_house_fill,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              icon: Icon(
                                CupertinoIcons.music_house,
                                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                              ),
                              label: Text(S.of(context).Home),
                            ),
                            NavigationRailDestination(
                              selectedIcon: Icon(
                                CupertinoIcons.search,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              icon: Icon(
                                CupertinoIcons.search,
                                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                              ),
                              label: Text(S.of(context).Search_Echo),
                            ),
                            NavigationRailDestination(
                              selectedIcon: Icon(
                                Icons.library_music_outlined,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              icon: Icon(
                                Icons.library_music_outlined,
                                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                              ),
                              label: Text(S.of(context).Saved),
                            ),
                            NavigationRailDestination(
                              selectedIcon: Icon(
                                CupertinoIcons.gear_alt_fill,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              icon: Icon(
                                CupertinoIcons.gear_alt,
                                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                              ),
                              label: Text(S.of(context).Settings),
                            )
                          ],
                          selectedIndex: widget.navigationShell.currentIndex,
                          onDestinationSelected: _goBranch,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: widget.navigationShell,
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: BottomPlayer(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: screenWidth < 450
          ? Container(
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              decoration: BoxDecoration(
                color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: NavigationBar(
                    selectedIndex: widget.navigationShell.currentIndex,
                    backgroundColor: Colors.transparent,
                    destinations: [
                      NavigationDestination(
                        selectedIcon: Icon(
                          CupertinoIcons.music_house_fill,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        icon: Icon(
                          CupertinoIcons.music_house,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                        ),
                        label: S.of(context).Home,
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          CupertinoIcons.search,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        icon: Icon(
                          CupertinoIcons.search,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                        ),
                        label: S.of(context).Search_Echo,
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.library_music,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        icon: Icon(
                          Icons.library_music_outlined,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                        ),
                        label: S.of(context).Saved,
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          CupertinoIcons.settings_solid,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        icon: Icon(
                          CupertinoIcons.settings,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                        ),
                        label: S.of(context).Settings,
                      ),
                    ],
                    onDestinationSelected: _goBranch,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
