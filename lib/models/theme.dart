
enum AppThemeModel { system, dark, light }


getAppThemeFromString(String value) =>
    {'light': AppThemeModel.light, 'dark': AppThemeModel.dark}[value] ??
    AppThemeModel.system;

String getThemeTitle(AppThemeModel theme) =>
    {
      'dark': "Dark mode",
      'light': "Light mode",
      'system': "Use system settings",
    }[theme.name] ??
    '';
