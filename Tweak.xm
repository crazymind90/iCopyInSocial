// By @CrazyMind90

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wunknown-pragmas"

#define rgbValue
#define UIColorFromHEX(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

id GetIvar(NSObject *insClass, NSString *key) {

    return [insClass valueForKey:key];
}



#define MutDiction [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.crazymind90.icopyinsocial.plist"]
#define WACustomView [[MutDiction objectForKey:@"WACustomView"] boolValue]
#define YTCustomView [[MutDiction objectForKey:@"YTCustomView"] boolValue]
#define INCustomView [[MutDiction objectForKey:@"INCustomView"] boolValue]
#define TWCustomView [[MutDiction objectForKey:@"TWCustomView"] boolValue]
#define MECustomView [[MutDiction objectForKey:@"MECustomView"] boolValue]


static UIViewController *_topMostController(UIViewController *cont) {
UIViewController *topController = cont;
 while (topController.presentedViewController) {
 topController = topController.presentedViewController;
 }
 if ([topController isKindOfClass:[UINavigationController class]]) {
 UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
 if (visible) {
topController = visible;
 }
}
 return (topController != cont ? topController : nil);
 }
 static UIViewController *topMostController() {
 UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
 UIViewController *next = nil;
  while ((next = _topMostController(topController)) != nil) {
 topController = next;
 }
 return topController;
}


void Alert(NSString *Title,NSString *Message) {

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

   }];

  [alert addAction:action];

  [topMostController() presentViewController:alert animated:true completion:nil];
}

@interface CMManager : NSObject
+(UITapGestureRecognizer *) InitTapGestureRecognizerInView:(UIView *)InView NumberOfTapsRequired:(NSUInteger)TapsRequired NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action;
+(UILongPressGestureRecognizer *) InitLongPressGestureRecognizerInView:(UIView *)InView PressDuration:(float)PressDuration NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action;
+(UITextView *_Nullable) InitTextViewWithFrame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor InView:(UIView *_Nullable)InView;
+(UIButton *) InitButtonWithName:(NSString *)BuName Frame:(CGRect)frame InView:(UIView *)View Target:(id)Target Action:(SEL)Action;
+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame BackgroundImage:(UIImage *_Nullable)BackgroundImage InView:(UIView *_Nullable)InView;
+(UILabel *) InitLabelWithName:(NSString *)Name Frame:(CGRect)frame InView:(UIView *)InView;
+(UIActivityViewController *_Nullable) ShareItemAtPath:(NSString *_Nullable)Path InViewController:(UIViewController *_Nullable)InViewController;
+(NSArray *_Nullable) InitButtonImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View Target:(id)Target Action:(SEL)Action;
@end

@implementation CMManager

+(NSArray *_Nullable) InitButtonImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View Target:(id)Target Action:(SEL)Action {


    UIImageView *ImageView = [[UIImageView alloc] init];

    ImageView.image = image;

    ImageView.layer.masksToBounds = YES;

    [View addSubview:ImageView];


    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

    [Button setTitle:@"" forState:UIControlStateNormal];

    [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];


    [View addSubview:Button];

    [Button setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[

    [Button.topAnchor constraintEqualToAnchor:ImageView.topAnchor constant:0],
    [Button.leadingAnchor constraintEqualToAnchor:ImageView.leadingAnchor constant:0],
    [Button.trailingAnchor constraintEqualToAnchor:ImageView.trailingAnchor constant:0],
    [Button.bottomAnchor constraintEqualToAnchor:ImageView.bottomAnchor constant:0],

    ]];

    NSArray *Values = @[Button,ImageView];

    return Values;

}


+(UIActivityViewController *_Nullable) ShareItemAtPath:(NSString *_Nullable)Path InViewController:(UIViewController *_Nullable)InViewController {

    // To save photo or video to CameraRoll - YOU MUST ADD "NSPhotoLibraryAddUsageDescription" Key to your Info.plist as string

        NSMutableArray *Items = [NSMutableArray new];

        [Items addObject:[NSURL fileURLWithPath:Path isDirectory:NO]];


        UIActivityViewController *Activity = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];

        [InViewController presentViewController:Activity animated:YES completion:^{


        }];


    return Activity;
}

+(UIButton *) InitButtonWithName:(NSString *)BuName Frame:(CGRect)frame InView:(UIView *)View Target:(id)Target Action:(SEL)Action {


       UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

       Button.frame = frame;

       [Button setTitle:BuName forState:UIControlStateNormal];


       [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];



       [View addSubview:Button];


    return Button;

}

+(UILongPressGestureRecognizer *) InitLongPressGestureRecognizerInView:(UIView *)InView PressDuration:(float)PressDuration NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action {

    UILongPressGestureRecognizer *LongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:Target action:Action];

    LongPress.numberOfTouchesRequired = TouchesRequired;
    LongPress.minimumPressDuration = PressDuration;
    [InView addGestureRecognizer:LongPress];


    return LongPress;

}

+(UITextView *_Nullable) InitTextViewWithFrame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor InView:(UIView *_Nullable)InView {

    UITextView *TextV = [[UITextView alloc] initWithFrame:Frame];

    TextV.backgroundColor = BGColor;
    TextV.textColor = TextColor;

    [InView addSubview:TextV];

    return TextV;
}


+(UITapGestureRecognizer *) InitTapGestureRecognizerInView:(UIView *)InView NumberOfTapsRequired:(NSUInteger)TapsRequired NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action {

    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:Target action:Action];

    Tap.numberOfTapsRequired = TapsRequired;
    Tap.numberOfTouchesRequired = TouchesRequired;

    Tap.delegate = Target;

    [InView addGestureRecognizer:Tap];


    return Tap;

}


+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame BackgroundImage:(UIImage *_Nullable)BackgroundImage InView:(UIView *_Nullable)InView {

    UIView *View = [[UIView alloc] initWithFrame:Frame];

    View.backgroundColor = BGColor;

    View.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

    if (BackgroundImage != nil) {

    UIImage *Image = BackgroundImage;

    View.layer.contents = (__bridge id _Nullable)(Image.CGImage);

    }

    [InView addSubview:View];

     return View;

}



+(UILabel *) InitLabelWithName:(NSString *)Name Frame:(CGRect)frame InView:(UIView *)InView {


    UILabel *Label = [[UILabel alloc] initWithFrame:frame];

    Label.text = Name;

    [InView addSubview:Label];

    return Label;
}

@end






@interface iCopyInSocialViewController : UIViewController

@property NSString *text;
@end


@implementation iCopyInSocialViewController

-(void) viewDidLoad {

 [super viewDidLoad];

    UIView *BaseView = [CMManager InitViewWithBGColor:UIColorFromHEX(0x151515) Frame:CGRectNull BackgroundImage:nil InView:self.view];

    BaseView.clipsToBounds = YES;
    BaseView.layer.cornerRadius = 12;

    [BaseView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[
    [BaseView.topAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-150],
    [BaseView.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-150],
    [BaseView.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:150],
    [BaseView.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:150],

    ]];


    UIView *NavigationView = [CMManager InitViewWithBGColor:UIColorFromHEX(0x121212) Frame:CGRectNull BackgroundImage:nil InView:self.view];

    NavigationView.clipsToBounds = YES;
    NavigationView.layer.cornerRadius = 12;
    NavigationView.layer.borderWidth = 0.1;

    if (@available(iOS 11.0, *))
    NavigationView.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMinXMinYCorner;

    [NavigationView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
    [NavigationView.topAnchor constraintEqualToAnchor:BaseView.topAnchor constant:-1],
    [NavigationView.leadingAnchor constraintEqualToAnchor:BaseView.leadingAnchor constant:-1],
    [NavigationView.trailingAnchor constraintEqualToAnchor:BaseView.trailingAnchor constant:1],
    [NavigationView.bottomAnchor constraintEqualToAnchor:BaseView.topAnchor constant:40],

    ]];


    UIButton *Close = [CMManager InitButtonWithName:@"Done" Frame:CGRectNull InView:NavigationView Target:self Action:@selector(Close)];

    Close.clipsToBounds = YES;

    Close.titleLabel.font = [UIFont systemFontOfSize:16];

    [Close setTitleColor:UIColorFromHEX(0x004bff) forState:UIControlStateNormal];

    [Close setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [Close.topAnchor constraintEqualToAnchor:NavigationView.topAnchor],
    [Close.leadingAnchor constraintEqualToAnchor:NavigationView.leadingAnchor constant:1.5],
    [Close.trailingAnchor constraintEqualToAnchor:NavigationView.leadingAnchor constant:60],
    [Close.bottomAnchor constraintEqualToAnchor:NavigationView.bottomAnchor],

    ]];


    NSArray *ShareArr = [CMManager InitButtonImage:[UIImage imageNamed:@"/Library/Application Support/iCopyInSocial.bundle/Share.png"] InView:NavigationView Target:self Action:@selector(Share)];

    UIImageView *Share = [ShareArr objectAtIndex:1];

    Share.clipsToBounds = YES;

    [Share setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [Share.topAnchor constraintEqualToAnchor:NavigationView.topAnchor constant:5],
    [Share.leadingAnchor constraintEqualToAnchor:NavigationView.trailingAnchor constant:-36],
    [Share.trailingAnchor constraintEqualToAnchor:NavigationView.trailingAnchor constant:-5],
    [Share.bottomAnchor constraintEqualToAnchor:NavigationView.bottomAnchor constant:-5],

    ]];


    UILabel *Title = [CMManager InitLabelWithName:@"iCopyInSocial" Frame:CGRectNull InView:NavigationView];

    Title.textColor = UIColor.whiteColor;
    Title.textAlignment = NSTextAlignmentCenter;
    Title.font = [UIFont systemFontOfSize:15];

    [Title setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [Title.topAnchor constraintEqualToAnchor:NavigationView.topAnchor],
    [Title.leadingAnchor constraintEqualToAnchor:NavigationView.centerXAnchor constant:-60],
    [Title.trailingAnchor constraintEqualToAnchor:NavigationView.centerXAnchor constant:60],
    [Title.bottomAnchor constraintEqualToAnchor:NavigationView.bottomAnchor],

    ]];


    UITextView *TextView = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x181818) TextColor:UIColor.whiteColor InView:BaseView];

    TextView.editable = YES;
    TextView.clipsToBounds = YES;
    TextView.font = [UIFont systemFontOfSize:12.5];
    TextView.textAlignment = NSTextAlignmentCenter;
    TextView.text = [NSString stringWithFormat:@"\n%@",self.text];
    [TextView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[

    [TextView.topAnchor constraintEqualToAnchor:NavigationView.bottomAnchor constant:0],
    [TextView.leadingAnchor constraintEqualToAnchor:BaseView.leadingAnchor constant:0],
    [TextView.trailingAnchor constraintEqualToAnchor:BaseView.trailingAnchor constant:0],
    [TextView.bottomAnchor constraintEqualToAnchor:BaseView.bottomAnchor constant:0],

    ]];

}

-(void) Close {

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) Share {

    [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/Library/iCopyInSocial",NSHomeDirectory()] contents:[self.text dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];

    [CMManager ShareItemAtPath:[NSString stringWithFormat:@"%@/Library/iCopyInSocial",NSHomeDirectory()] InViewController:topMostController()];
}

@end




#pragma WhatsApp_

%group WhatsApp

@interface WAMessage : NSObject

@property NSString *textToSpeak;
@end

@interface WAChatCellData : NSObject

@property WAMessage *message;
@end

@interface WAMessageContainerView : UIView

@property WAChatCellData *cellData;
-(void) WAWordCopy;
@end

UITextView *TextView;

%hook WAMessageContainerView
-(void) layoutSubviews {

     %orig;

  if (WACustomView)
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(WAWordCopyCustom)];
  else
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(WAWordCopy)];

}

%new
-(void) WAWordCopyCustom {

 NSString *OriginalText = self.cellData.message.textToSpeak;

 iCopyInSocialViewController *iCopy = [[iCopyInSocialViewController alloc] init];

[iCopy setText:OriginalText];

[topMostController() presentViewController:iCopy animated:YES completion:nil];
}

%new
-(void) WAWordCopy {

 #pragma Gettin_Message_From_Tapped_Cell
 NSString *OriginalText = self.cellData.message.textToSpeak;


 if (OriginalText) {

 #pragma Drawing_TextView_On_Tapped_Cell
 TextView = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x252525) TextColor:UIColor.whiteColor InView:self];

 TextView.editable = YES;
 TextView.layer.cornerRadius = 7;
 TextView.clipsToBounds = YES;
 TextView.text = OriginalText;
 TextView.font = [UIFont systemFontOfSize:15];

 [TextView setTranslatesAutoresizingMaskIntoConstraints:NO];

 [NSLayoutConstraint activateConstraints:@[

 [TextView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
 [TextView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
 [TextView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
 [TextView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],

 ]];

 }

}

%end


@interface WAChatViewController : UIViewController

@end

%hook WAChatViewController
-(void) viewDidLoad {
  %orig;
  [CMManager InitTapGestureRecognizerInView:self.view NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(Dismiss)];
}

%new
-(void) Dismiss {

  #pragma Dismissing_TextView
  [TextView setHidden:YES];
  [TextView removeFromSuperview];

}
%end



%end






#pragma Youtube
%group Youtube


@interface YTFormattedStringLabel : UILabel

-(void) YTWordCopy;
@end



UITextView *TextView_Youtube;

%hook YTFormattedStringLabel
-(void) applyTypeStyle {

     %orig;

  if (YTCustomView)
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(YTWordCopyCustom)];
  else
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(YTWordCopy)];
}

%new
-(void) YTWordCopyCustom {

 NSString *OriginalText = self.attributedText.string;

 iCopyInSocialViewController *iCopy = [[iCopyInSocialViewController alloc] init];

[iCopy setText:OriginalText];

[topMostController() presentViewController:iCopy animated:YES completion:nil];
}

%new
-(void) YTWordCopy {

 NSString *OriginalText = self.attributedText.string;


 if (OriginalText) {

 TextView_Youtube = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x252525) TextColor:UIColor.whiteColor InView:self];

 TextView_Youtube.editable = YES;
 TextView_Youtube.layer.cornerRadius = 7;
 TextView_Youtube.clipsToBounds = YES;
 TextView_Youtube.text = OriginalText;
 TextView_Youtube.font = [UIFont systemFontOfSize:15];

 [TextView_Youtube setTranslatesAutoresizingMaskIntoConstraints:NO];

 [NSLayoutConstraint activateConstraints:@[

 [TextView_Youtube.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
 [TextView_Youtube.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
 [TextView_Youtube.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
 [TextView_Youtube.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],

 ]];

  }

}



%end


%hook YTEngagementPanelViewController
-(void) didTapCloseButton {

  %orig;
  [TextView_Youtube setHidden:YES];
  [TextView_Youtube removeFromSuperview];
}
%end


%end









%group Twitter

@interface TFNTiledTextLayerState : NSObject

@property NSAttributedString *attributedString;
@end

@interface TFNTiledTextLayer : NSObject

@property TFNTiledTextLayerState *state;
@end

@interface TFNAttributedTextView : UIView

@end

@interface TFNTilingTextView : TFNAttributedTextView

@property TFNTiledTextLayer *tiledLayer;
@end

@interface TFNSpacerView : UIView

-(void) TWCopyDM;
@end

// TFNTilingTextView

UITextView *TextView_Twitter;

%hook TFNSpacerView
-(void) layoutSubviews {

     %orig;

  if (TWCustomView)
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:1 NumberOfTouchesRequired:1 Target:self Actions:@selector(TWCopyDMCustom)];
  else
  [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:1 NumberOfTouchesRequired:1 Target:self Actions:@selector(TWCopyDM)];

}

%new
-(void) TWCopyDMCustom {

  TFNTilingTextView *GG = [self.subviews objectAtIndex:0];

  NSString *OriginalText = GG.tiledLayer.state.attributedString.string;

  iCopyInSocialViewController *iCopy = [[iCopyInSocialViewController alloc] init];

  [iCopy setText:OriginalText];

  [topMostController() presentViewController:iCopy animated:YES completion:nil];
}

%new
-(void) TWCopyDM {

 TFNTilingTextView *GG = [self.subviews objectAtIndex:0];

 NSString *OriginalText = GG.tiledLayer.state.attributedString.string;


 if (OriginalText) {

 if (TextView_Twitter) {

   #pragma Dismissing_previous_TextView
   [TextView_Twitter setHidden:YES];
   [TextView_Twitter removeFromSuperview];
 }

 TextView_Twitter = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x252525) TextColor:UIColor.whiteColor InView:self];

 TextView_Twitter.editable = YES;
 TextView_Twitter.clipsToBounds = YES;
 TextView_Twitter.text = OriginalText;
 TextView_Twitter.font = [UIFont systemFontOfSize:15];
 TextView_Twitter.textAlignment = NSTextAlignmentCenter;

 [TextView_Twitter setTranslatesAutoresizingMaskIntoConstraints:NO];

 [NSLayoutConstraint activateConstraints:@[

 [TextView_Twitter.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
 [TextView_Twitter.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
 [TextView_Twitter.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
 [TextView_Twitter.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],

 ]];

  }

}



%end


@interface T1DirectMessageConversationEntriesViewController : UIViewController

-(void) Dismiss;
@end

%hook T1DirectMessageConversationEntriesViewController
-(void) viewDidLoad {
  %orig;
  [CMManager InitTapGestureRecognizerInView:self.view NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(Dismiss)];
}

%new
-(void) Dismiss {

  #pragma Dismissing_TextView
  [TextView_Twitter setHidden:YES];
  [TextView_Twitter removeFromSuperview];

}
%end


%end






#pragma Instagram

%group Instagram


@interface IGCoreTextView : UITextView

@end


UITextView *TextView_Instagram;

%hook IGCoreTextView
-(void) layoutSubviews {

      %orig;

    if (INCustomView)
    [CMManager InitLongPressGestureRecognizerInView:self PressDuration:0.40f NumberOfTouchesRequired:1 Target:self Actions:@selector(IGCopyCommentCustom:)];
    else
    [CMManager InitLongPressGestureRecognizerInView:self PressDuration:0.40f NumberOfTouchesRequired:1 Target:self Actions:@selector(IGCopyComment:)];

}

%new
-(void) IGCopyCommentCustom:(UILongPressGestureRecognizer *)Sender {

  if (Sender.state == UIGestureRecognizerStateBegan) {

  NSString *OriginalText = self.text;

  iCopyInSocialViewController *iCopy = [[iCopyInSocialViewController alloc] init];

  [iCopy setText:OriginalText];

  [topMostController() presentViewController:iCopy animated:YES completion:nil];

  }
}

%new
-(void) IGCopyComment:(UILongPressGestureRecognizer *)Sender {

 if (Sender.state == UIGestureRecognizerStateBegan) {
 NSString *OriginalText = self.text;


 if (OriginalText) {

 if (TextView_Instagram) {

   #pragma Dismissing_previous_TextView
   [TextView_Instagram setHidden:YES];
   [TextView_Instagram removeFromSuperview];
 }

 TextView_Instagram = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x252525) TextColor:UIColor.whiteColor InView:self];

 TextView_Instagram.editable = YES;
 TextView_Instagram.clipsToBounds = YES;
 TextView_Instagram.layer.cornerRadius = 10;
 TextView_Instagram.text = OriginalText;
 TextView_Instagram.font = [UIFont systemFontOfSize:12.5];
 TextView_Instagram.textAlignment = NSTextAlignmentCenter;

 [TextView_Instagram setTranslatesAutoresizingMaskIntoConstraints:NO];

 [NSLayoutConstraint activateConstraints:@[

 [TextView_Instagram.topAnchor constraintEqualToAnchor:self.topAnchor constant:-5],
 [TextView_Instagram.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
 [TextView_Instagram.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
 [TextView_Instagram.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:5],

 ]];

 UIButton *Close = [CMManager InitButtonWithName:@"X" Frame:CGRectNull InView:TextView_Instagram Target:self Action:@selector(Close)];

 Close.clipsToBounds = YES;
 Close.layer.cornerRadius = 12;
 Close.layer.backgroundColor = UIColorFromHEX(0x050505).CGColor;

 [Close setTranslatesAutoresizingMaskIntoConstraints:NO];

 [NSLayoutConstraint activateConstraints:@[

 [Close.topAnchor constraintEqualToAnchor:TextView_Instagram.topAnchor constant:1.5],
 [Close.leadingAnchor constraintEqualToAnchor:TextView_Instagram.leadingAnchor constant:1.5],
 [Close.trailingAnchor constraintEqualToAnchor:TextView_Instagram.leadingAnchor constant:25],
 [Close.bottomAnchor constraintEqualToAnchor:TextView_Instagram.topAnchor constant:25],

 ]];

    }
  }
}

%new
-(void) Close {

  #pragma Dismissing_previous_TextView
  [TextView_Instagram setHidden:YES];
  [TextView_Instagram removeFromSuperview];
}

%end


%end







#pragma Messages

%group Messages


@interface CKBalloonTextView : UITextView

-(void) CopyMobileSMS;
@end


UITextView *TextView_Messages;

%hook CKBalloonTextView
-(void) layoutSubviews {

    %orig;

    if (MECustomView)
    [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:1 NumberOfTouchesRequired:1 Target:self Actions:@selector(CopyMobileSMSCustom)];
    else
    [CMManager InitTapGestureRecognizerInView:self NumberOfTapsRequired:1 NumberOfTouchesRequired:1 Target:self Actions:@selector(CopyMobileSMS)];
}
%new
-(void) CopyMobileSMSCustom {

  NSString *OriginalText = self.text;

  iCopyInSocialViewController *iCopy = [[iCopyInSocialViewController alloc] init];

  [iCopy setText:OriginalText];

  [topMostController() presentViewController:iCopy animated:YES completion:nil];

}
%new
-(void) CopyMobileSMS {

  NSString *OriginalText = self.text;

 TextView_Messages = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColorFromHEX(0x252525) TextColor:UIColor.whiteColor InView:topMostController().view];

 TextView_Messages.editable = YES;
 TextView_Messages.clipsToBounds = YES;
 TextView_Messages.layer.cornerRadius = 10;
 TextView_Messages.text = OriginalText;
 TextView_Messages.font = [UIFont systemFontOfSize:15];
 TextView_Messages.textAlignment = NSTextAlignmentCenter;

 [TextView_Messages setTranslatesAutoresizingMaskIntoConstraints:NO];
 [NSLayoutConstraint activateConstraints:@[

 [TextView_Messages.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
 [TextView_Messages.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
 [TextView_Messages.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
 [TextView_Messages.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],

 ]];

}

%end


@interface CKTranscriptCollectionViewController : UIViewController

@end

%hook CKTranscriptCollectionViewController
-(void) viewDidLoad {
  %orig;

  [CMManager InitTapGestureRecognizerInView:self.view NumberOfTapsRequired:2 NumberOfTouchesRequired:1 Target:self Actions:@selector(Dismiss)];
}

%new
-(void) Dismiss {

  #pragma Dismissing_TextView
  [TextView_Messages setHidden:YES];
  [TextView_Messages removeFromSuperview];

}
%end




%end







BOOL Check_If_Bundle_Exists(NSString *Bundle) {

    BOOL Found = NO;

    NSMutableDictionary *Open = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/iCopyInSocial.plist"];

    NSDictionary *Filter = [Open objectForKey:@"Filter"];

    NSArray *Bundles = [Filter objectForKey:@"Bundles"];

    for (NSString *EachBundle in Bundles) {

    if ([EachBundle isEqual:Bundle]) {

    Found = YES;

   }
 }

    return Found;
}

%ctor {

  bool Enabled = [[MutDiction objectForKey:@"Aw"] boolValue];
	bool whatsApp_ = [[MutDiction objectForKey:@"WhatsApp"] boolValue];
  bool Youtube_ = [[MutDiction objectForKey:@"Youtube"] boolValue];
  bool Twitter_ = [[MutDiction objectForKey:@"Twitter"] boolValue];
  bool Instagram_ = [[MutDiction objectForKey:@"Instagram"] boolValue];
  bool Messages_ = [[MutDiction objectForKey:@"Messages"] boolValue];



	if (!Enabled)
  return;


  if (whatsApp_ && Check_If_Bundle_Exists(NSBundle.mainBundle.bundleIdentifier))
  %init(WhatsApp);

  if (Youtube_ && Check_If_Bundle_Exists(NSBundle.mainBundle.bundleIdentifier))
  %init(Youtube);

  if (Twitter_ && Check_If_Bundle_Exists(NSBundle.mainBundle.bundleIdentifier))
  %init(Twitter);

  if (Instagram_ && Check_If_Bundle_Exists(NSBundle.mainBundle.bundleIdentifier))
  %init(Instagram);

  if (Messages_ && Check_If_Bundle_Exists(NSBundle.mainBundle.bundleIdentifier))
  %init(Messages);

}















//
