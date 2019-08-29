package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.thl.flustars.FlustarsPlugin;
import com.dfa.introslider.IntroSliderPlugin;
import com.oversketch.progresshud.ProgresshudPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlustarsPlugin.registerWith(registry.registrarFor("com.thl.flustars.FlustarsPlugin"));
    IntroSliderPlugin.registerWith(registry.registrarFor("com.dfa.introslider.IntroSliderPlugin"));
    ProgresshudPlugin.registerWith(registry.registrarFor("com.oversketch.progresshud.ProgresshudPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
