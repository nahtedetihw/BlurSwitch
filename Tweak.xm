#import "Tweak.h"

BOOL enabled;
BOOL disableVibration;
NSInteger knobBlurStyle;
HBPreferences *preferences;

//Color dictionary
NSMutableDictionary *colorDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nahtedetihw.blurswitchcolours.plist"];

%group BlurSwitch

%hook UISwitchModernVisualElement
-(void)tintColorDidChange {
    %orig;
    // Remove the existing knob image
    UIImageView *knobView = MSHookIvar<UIImageView *>(self, "_knobView");
    knobView.image = nil;
    
    // Set the blur
    UIBlurEffect *blurSwitchEffect;
    
        switch (knobBlurStyle) {
        case 0:
            blurSwitchEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
        break;
    
        case 1:
            blurSwitchEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
        break;
    
        case 2:
            blurSwitchEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        break;

        default:
            blurSwitchEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
        break;
        }
    
    // Add the blur to the view and set the frame of the view
    UIVisualEffectView *blurSwitchEffectView = [[UIVisualEffectView alloc] initWithEffect:blurSwitchEffect];
    blurSwitchEffectView.frame = CGRectMake(5, 2, 34, 34);
    blurSwitchEffectView.layer.cornerRadius = 17;
    blurSwitchEffectView.layer.masksToBounds = YES;
    
    // Add the blur view to the original knobview
    [knobView insertSubview:blurSwitchEffectView atIndex:0];
    
    [self setNeedsDisplay];
}

// Remove the existing knob image when it is transitioning
-(id)_effectiveThumbImage {
    return nil;
}

// Set the background color of the switch in the on position
-(id)_effectiveOnTintColor {
return [SparkColourPickerUtils colourWithString:[colorDictionary objectForKey:@"onColorKey"] withFallback:@"#30D158"];
[self setNeedsDisplay];
}

// Set the background color of the switch in the off position
-(id)_effectiveTintColor {
return [SparkColourPickerUtils colourWithString:[colorDictionary objectForKey:@"offColorKey"] withFallback:@"#8B8A8E"];
[self setNeedsDisplay];
}

// Disable vibrations
-(BOOL)_feedbackEnabled {
    if (disableVibration) {
        return NO;
    }
    return %orig;
}

%end


%end

%ctor {

    BOOL shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
            BOOL isPreferences = [processName isEqualToString:@"Preferences"];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"]
            || [processName isEqualToString:@"CoreAuthUI"]
            || [processName isEqualToString:@"InCallService"]
            || [processName isEqualToString:@"MessagesNotificationViewService"]
            || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if (!isFileProvider && (isSpringBoard || isApplication || isPreferences) && !skip) {
                shouldLoad = YES;
            }
        }
    }
    if (shouldLoad) {
    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.nahtedetihw.blurswitchprefs"];
    [preferences registerBool:&enabled default:NO forKey:@"enabled"];
    [preferences registerInteger:&knobBlurStyle default:0 forKey:@"knobBlurStyle"];
    [preferences registerBool:&disableVibration default:NO forKey:@"disableVibration"];

    if (enabled) {
        %init(BlurSwitch);

        return;

    }

    return;

}

}
