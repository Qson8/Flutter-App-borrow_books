//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <flustars/FlustarsPlugin.h>
#import <intro_slider/IntroSliderPlugin.h>
#import <ovprogresshud/ProgresshudPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlustarsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlustarsPlugin"]];
  [IntroSliderPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntroSliderPlugin"]];
  [ProgresshudPlugin registerWithRegistrar:[registry registrarForPlugin:@"ProgresshudPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
