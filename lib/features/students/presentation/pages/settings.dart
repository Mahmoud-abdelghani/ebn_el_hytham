import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static const routeName = '/settings';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDarkAppBar('Settings'),

      body: Column(
        children: [
          if (context.watch<VoiceHelperCubit>().isStudentSession)
            ListTile(
              trailing: !context.watch<VoiceHelperCubit>().isOn
                  ? IconButton(
                      color: ColorGuid.amber,
                      onPressed: () async {
                        await BlocProvider.of<VoiceHelperCubit>(context)
                            .start();
                        setState(() {});
                      },
                      icon: Icon(Icons.mic_none_rounded),
                    )
                  : IconButton(
                      color: ColorGuid.amberBorder,
                      onPressed: () async {
                        await BlocProvider.of<VoiceHelperCubit>(context).stop();
                        setState(() {});
                      },
                      icon: Icon(Icons.mic_off_outlined),
                    ),
              subtitle: Text(
                'Enable or disable Voice Assistant',
                style: TextStyle(color: ColorGuid.textMuted),
              ),
              title: Text(
                'Voice Assistant',
                style: TextStyle(
                  color: ColorGuid.textPrimary,
                  fontSize: ScreenSize.height * 0.023,
                ),
              ),
              leading: Icon(
                Icons.mic,
                color: ColorGuid.amber,
                size: ScreenSize.height * 0.04,
              ),
            ),
        ],
      ),
    );
  }
}
