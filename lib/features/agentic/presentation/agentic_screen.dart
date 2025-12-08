import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';
import '../../../core/state/app_state.dart';

class AgenticScreen extends StatelessWidget {
  const AgenticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agentic Control'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const ThemeModeSelector(),
          const SizedBox(height: 20),
          const FlexSchemeSelector(),
          const SizedBox(height: 20),
          const GoogleFontsSelector(),
        ],
      ),
    );
  }
}

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final current = AppState.instance.themeMode.watch(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette_outlined, color: colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Theme Mode',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ModeButton(
                  mode: ThemeMode.light,
                  selected: current == ThemeMode.light,
                  icon: Icons.light_mode,
                  label: 'Light',
                ),
                _ModeButton(
                  mode: ThemeMode.dark,
                  selected: current == ThemeMode.dark,
                  icon: Icons.dark_mode,
                  label: 'Dark',
                ),
                _ModeButton(
                  mode: ThemeMode.system,
                  selected: current == ThemeMode.system,
                  icon: Icons.brightness_auto,
                  label: 'System',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final ThemeMode mode;
  final bool selected;
  final IconData icon;
  final String label;

  const _ModeButton({
    required this.mode,
    required this.selected,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: () => AppState.instance.setThemeMode(mode),
          icon: Icon(icon, size: 28),
          isSelected: selected,
          style: IconButton.styleFrom(
            backgroundColor: selected ? colorScheme.primary : null,
            foregroundColor: selected ? colorScheme.onPrimary : null,
            padding: const EdgeInsets.all(20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class FlexSchemeSelector extends StatelessWidget {
  const FlexSchemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final current = AppState.instance.flexScheme.watch(context);
    AppState.instance.customFlexSchemeColor.watch(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(Icons.color_lens_outlined, color: colorScheme.primary),
        title: Text(
          'Color Scheme',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(current.name),
        ),
        children: [
          if (current == FlexScheme.custom)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom Color',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _ColorOption(Colors.blue),
                      _ColorOption(Colors.red),
                      _ColorOption(Colors.green),
                      _ColorOption(Colors.purple),
                      _ColorOption(Colors.orange),
                      _ColorOption(Colors.teal),
                      _ColorOption(Colors.pink),
                      _ColorOption(Colors.indigo),
                    ],
                  ),
                  const Divider(height: 32),
                ],
              ),
            ),
          SizedBox(
            height: 350,
            child: RadioGroup<FlexScheme>(
              groupValue: current,
              onChanged: (val) {
                if (val != null) AppState.instance.setFlexScheme(val);
              },
              child: ListView.builder(
                itemCount: FlexScheme.values.length,
                itemBuilder: (context, index) {
                  final scheme = FlexScheme.values[index];
                  return ListTile(
                    title: Text(scheme.name),
                    leading: Radio<FlexScheme>(value: scheme),
                    onTap: () => AppState.instance.setFlexScheme(scheme),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  const _ColorOption(this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppState.instance.setCustomFlexSchemeColor(
          FlexSchemeColor.from(primary: color),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleFontsSelector extends StatefulWidget {
  const GoogleFontsSelector({super.key});

  @override
  State<GoogleFontsSelector> createState() => _GoogleFontsSelectorState();
}

class _GoogleFontsSelectorState extends State<GoogleFontsSelector> {
  final _searchController = TextEditingController();
  List<String> _allFonts = [];
  List<String> _filteredFonts = [];

  @override
  void initState() {
    super.initState();
    _allFonts = GoogleFonts.asMap().keys.toList()..sort();
    _filteredFonts = _allFonts;
    _searchController.addListener(_filterFonts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFonts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFonts = _allFonts;
      } else {
        _filteredFonts = _allFonts
            .where((font) => font.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = AppState.instance.fontFamily.watch(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(Icons.font_download_outlined, color: colorScheme.primary),
        title: Text(
          'Font Family',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('$current (${_allFonts.length} fonts available)'),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search fonts...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 400,
            child: _filteredFonts.isEmpty
                ? Center(
                    child: Text(
                      'No fonts found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : RadioGroup<String>(
                    groupValue: current,
                    onChanged: (val) {
                      if (val != null) AppState.instance.setFontFamily(val);
                    },
                    child: ListView.builder(
                      itemCount: _filteredFonts.length,
                      itemBuilder: (context, index) {
                        final font = _filteredFonts[index];
                        return ListTile(
                          title: Text(
                            font,
                            style: GoogleFonts.getFont(font, fontSize: 16),
                          ),
                          leading: Radio<String>(value: font),
                          selected: font == current,
                          onTap: () => AppState.instance.setFontFamily(font),
                        );
                      },
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Showing ${_filteredFonts.length} of ${_allFonts.length} fonts',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
