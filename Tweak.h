#import <Cephei/HBPreferences.h>
#import <AudioToolbox/AudioServices.h>
#import <UIKit/UIKit.h>
#import <HBLog.h>
#import "SparkColourPickerUtils.h"
#import "SparkColourPickerView.h"

@interface UISwitchModernVisualElement
@property (assign,nonatomic) BOOL on;
-(void)setNeedsDisplay;
-(BOOL)displayedOn;
-(BOOL)pressed;
- (BOOL)isKindOfClass:(Class)aClass;
-(void)_updateDisplayWithAnimationIfNeeded;
@end
