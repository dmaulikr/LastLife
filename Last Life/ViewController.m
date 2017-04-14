//
//  ViewController.m
//  Last Life
//
//  Created by Ken Hung on 10/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define FLOATING_VIEW_WIDTH 200
#define FLOATING_VIEW_HEIGHT 200
#import "ViewController.h"

@interface ViewController ()
    - (void) endTurnFirstPlayer;
    - (void) endTurnSecondPlayer;
    - (void) syncFirstPlayerModelAndView;
    - (void) syncSecondPlayerModelAndView;
    - (NSInteger) coinFlip;
    - (void) displayFadeOutWithTitle: (NSString *) titleToFade withLabel: (UILabel *) label;
    - (void) displayFloatingCombatTextWithNumber: (NSInteger) number inView: (UIView *) view withColor: (UIColor *) color;
@end

@implementation ViewController
@synthesize firstPlayerView, secondPlayerView, firstPlayer, secondPlayer, firstPlayerlabel, secondPlayerlabel, firstPlayerStatusLabel, secondPlayerStatusLabel, globalStatusLabel;

- (void) displayFadeOutWithTitle: (NSString *) titleToFade withLabel: (UILabel *) label {
    // Remove this title from superview and free it if we've loading something already
 //   if (label != nil) {
        // resetn alpha and text
    [label setHidden: NO];
    [label setAlpha: 1.0f];
 //       [label setText: titleToFade];
 //   } else {
        // Init a fading title label
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
     //   [label setFont: [UIFont boldSystemFontOfSize: 14]];
    [label setBackgroundColor: [UIColor colorWithRed: 49.0f/255.0f green: 79.0f/255.0f blue: 79.0/255.0f alpha:0.55f]];
    [label setTextColor: [UIColor whiteColor]];
    [label setText: titleToFade];
    label.userInteractionEnabled = NO;
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 1;
    label.minimumFontSize = 6;
    label.adjustsFontSizeToFitWidth = YES;
 //   }
    
    // animate fade out
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:6];
    [label setAlpha:0];
    [UIView commitAnimations];
}

- (void) displayFloatingCombatTextWithNumber: (NSInteger) number inView: (UIView *) view withColor: (UIColor *) color {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width / 2 - (FLOATING_VIEW_WIDTH / 2), view.bounds.size.height / 2 - (FLOATING_VIEW_HEIGHT / 2), FLOATING_VIEW_WIDTH, FLOATING_VIEW_HEIGHT)];

    [label setAlpha: 0.85f];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [label setFont: [UIFont boldSystemFontOfSize: 150]];
    [label setBackgroundColor: [UIColor clearColor]];//[UIColor colorWithRed: 49.0f/255.0f green: 79.0f/255.0f blue: 79.0/255.0f alpha:0.75f]];
    [label setTextColor: color];
    
    if (number < 0)
        [label setText: [NSString stringWithFormat: @"%d", number]];
    else
        [label setText: [NSString stringWithFormat: @"+%d", number]];
    
    label.userInteractionEnabled = NO;
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 1;
    label.minimumFontSize = 6;
    label.adjustsFontSizeToFitWidth = YES;
    
    [view addSubview: label];
    
    int randomWidth = arc4random() % (NSInteger)view.bounds.size.width - (FLOATING_VIEW_WIDTH / 2);
    if (randomWidth < 0) {
        randomWidth = 0;
    }
    
    // animate fade out
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.5];
    
    if (number < 0) {
        // Float up
     //   [label setFrame: CGRectMake(view.bounds.size.width / 2 - (FLOATING_VIEW_WIDTH / 2), (view.bounds.size.height / 2 - (FLOATING_VIEW_HEIGHT / 2)) + 300, FLOATING_VIEW_WIDTH, FLOATING_VIEW_HEIGHT)];
        
        [label setFrame: CGRectMake(randomWidth, (view.bounds.size.height / 2 - (FLOATING_VIEW_HEIGHT / 2)) + 300, FLOATING_VIEW_WIDTH, FLOATING_VIEW_HEIGHT)];
    } else {
         // float down
     //   [label setFrame: CGRectMake(view.bounds.size.width / 2 - (FLOATING_VIEW_WIDTH / 2), (view.bounds.size.height / 2 - (FLOATING_VIEW_HEIGHT / 2)) - 300, FLOATING_VIEW_WIDTH, FLOATING_VIEW_HEIGHT)];
        
         [label setFrame: CGRectMake(randomWidth, (view.bounds.size.height / 2 - (FLOATING_VIEW_HEIGHT / 2)) - 300, FLOATING_VIEW_WIDTH, FLOATING_VIEW_HEIGHT)];
    }
    
    [label setAlpha:0];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) syncFirstPlayerModelAndView {
    self.firstPlayerlabel.text = [NSString stringWithFormat: @"%d", self.firstPlayer.currentLifeCount];
}

- (void) syncSecondPlayerModelAndView {
    self.secondPlayerlabel.text = [NSString stringWithFormat: @"%d", self.secondPlayer.currentLifeCount];
}

- (void) endTurnFirstPlayer {
    if ([self.firstPlayer didPlayerLose] || [self.secondPlayer didPlayerLose])
        return;
    
    self->activePlayer = 2;
    self.firstPlayerView.backgroundColor = [UIColor colorWithRed:0.45 green:0.10 blue:0.10 alpha:0.35];
    self.secondPlayerView.backgroundColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.80 alpha:0.90];
}

- (void) endTurnSecondPlayer {
    if ([self.firstPlayer didPlayerLose] || [self.secondPlayer didPlayerLose])
        return;
    
    self->activePlayer = 1;
    self.firstPlayerView.backgroundColor = [UIColor colorWithRed:0.75 green:0.30 blue:0.30 alpha:0.90];
    self.secondPlayerView.backgroundColor = [UIColor colorWithRed:0.10 green:0.10 blue:0.45 alpha:0.35];
}

- (NSInteger) coinFlip {
     return (arc4random() % 2) + 1;
}

- (void) showCoinFlip: (id) sender {
    if ([self coinFlip] == 1) {
        [self displayFadeOutWithTitle: @"Heads" withLabel: self.globalStatusLabel];
    } else {
        [self displayFadeOutWithTitle: @"Tails" withLabel: self.globalStatusLabel];
    }
}

- (void) resetGame: (id) sender {
    self->activePlayer = 0;
    
    [self.firstPlayer resetLifeCount];
    [self.secondPlayer resetLifeCount];
    
    [self syncFirstPlayerModelAndView];
    [self syncSecondPlayerModelAndView];
    
    int res = [self coinFlip];
    
    [self.firstPlayerStatusLabel setHidden: YES];
    [self.secondPlayerStatusLabel setHidden: YES];
    [self.globalStatusLabel setHidden: YES];
    
    if (res == 1) {
        [self endTurnSecondPlayer];
        [self displayFadeOutWithTitle: @"Plays First" withLabel: self.firstPlayerStatusLabel];
    } else {
        [self endTurnFirstPlayer];
        [self displayFadeOutWithTitle: @"Plays First" withLabel: self.secondPlayerStatusLabel];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstPlayer = [[PlayerLifeCounter alloc] init];
    self.secondPlayer = [[PlayerLifeCounter alloc] init];
    
    [self resetGame: nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(onFirstPlayerGesture:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 2;
    [self.firstPlayerView addGestureRecognizer: tapGestureRecognizer];
    [tapGestureRecognizer release];
    
    for (int i = 1; i < 4; i++) {
        UISwipeGestureRecognizer * swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onFirstPlayerGesture:)];
        swipeGestureRecognizer.numberOfTouchesRequired = i;
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self.firstPlayerView addGestureRecognizer: swipeGestureRecognizer];
        [swipeGestureRecognizer release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer01 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onFirstPlayerGesture:)];
        swipeGestureRecognizer01.numberOfTouchesRequired = i;
        swipeGestureRecognizer01.direction = UISwipeGestureRecognizerDirectionRight;
        [self.firstPlayerView addGestureRecognizer: swipeGestureRecognizer01];
        [swipeGestureRecognizer01 release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer02 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onFirstPlayerGesture:)];
        swipeGestureRecognizer02.numberOfTouchesRequired = i;
        swipeGestureRecognizer02.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.firstPlayerView addGestureRecognizer: swipeGestureRecognizer02];
        [swipeGestureRecognizer02 release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onFirstPlayerGesture:)];
        swipeGestureRecognizer2.numberOfTouchesRequired = i;
        swipeGestureRecognizer2.direction = UISwipeGestureRecognizerDirectionUp;
        [self.firstPlayerView addGestureRecognizer: swipeGestureRecognizer2];
        [swipeGestureRecognizer2 release];
    }
    
    UITapGestureRecognizer * tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(onSecondPlayerGesture:)];
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    tapGestureRecognizer2.numberOfTouchesRequired = 2;
    [self.secondPlayerView addGestureRecognizer: tapGestureRecognizer2];
    [tapGestureRecognizer2 release];
    
    for (int i = 1; i < 4; i++) {
        UISwipeGestureRecognizer * swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSecondPlayerGesture:)];
        swipeGestureRecognizer.numberOfTouchesRequired = i;
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self.secondPlayerView addGestureRecognizer: swipeGestureRecognizer];
        [swipeGestureRecognizer release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer01 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSecondPlayerGesture:)];
        swipeGestureRecognizer01.numberOfTouchesRequired = i;
        swipeGestureRecognizer01.direction = UISwipeGestureRecognizerDirectionRight;
        [self.secondPlayerView addGestureRecognizer: swipeGestureRecognizer01];
        [swipeGestureRecognizer01 release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer02 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSecondPlayerGesture:)];
        swipeGestureRecognizer02.numberOfTouchesRequired = i;
        swipeGestureRecognizer02.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.secondPlayerView addGestureRecognizer: swipeGestureRecognizer02];
        [swipeGestureRecognizer02 release];
        
        UISwipeGestureRecognizer * swipeGestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSecondPlayerGesture:)];
        swipeGestureRecognizer2.numberOfTouchesRequired = i;
        swipeGestureRecognizer2.direction = UISwipeGestureRecognizerDirectionUp;
        [self.secondPlayerView addGestureRecognizer: swipeGestureRecognizer2];
        [swipeGestureRecognizer2 release];
    }
}

- (void) onFirstPlayerGesture: (id) sender {
    if ([sender isKindOfClass: [UISwipeGestureRecognizer class] ]) {
        UISwipeGestureRecognizer * sgr = sender;
        
        switch (sgr.numberOfTouches) {
            case 1:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.firstPlayer subtractFromCurrentLifeCount: 1];
                    [self displayFloatingCombatTextWithNumber: -1 inView: self.firstPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.firstPlayer addToCurrentLifeCount: 1];
                    [self displayFloatingCombatTextWithNumber: 1 inView: self.firstPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            case 2:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.firstPlayer subtractFromCurrentLifeCount: 2];
                    [self displayFloatingCombatTextWithNumber: -2 inView: self.firstPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.firstPlayer addToCurrentLifeCount: 2];
                    [self displayFloatingCombatTextWithNumber: 2 inView: self.firstPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            case 3:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.firstPlayer subtractFromCurrentLifeCount: 3];
                    [self displayFloatingCombatTextWithNumber: -3 inView: self.firstPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.firstPlayer addToCurrentLifeCount: 3];
                    [self displayFloatingCombatTextWithNumber: 3 inView: self.firstPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            default:
                break;
        }
        
        [self syncFirstPlayerModelAndView];
    }
    
    if ([sender isKindOfClass: [UITapGestureRecognizer class]]) {
        // UITapGestureRecognizer * tgr = sender;
        
        [self endTurnFirstPlayer];
    }
}

- (void) onSecondPlayerGesture: (id) sender {
    if ([sender isKindOfClass: [UISwipeGestureRecognizer class] ]) {
        UISwipeGestureRecognizer * sgr = sender;
        
        switch (sgr.numberOfTouches) {
            case 1:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.secondPlayer subtractFromCurrentLifeCount: 1];
                    [self displayFloatingCombatTextWithNumber: -1 inView: self.secondPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.secondPlayer addToCurrentLifeCount: 1];
                    [self displayFloatingCombatTextWithNumber: 1 inView: self.secondPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            case 2:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.secondPlayer subtractFromCurrentLifeCount: 2];
                    [self displayFloatingCombatTextWithNumber: -2 inView: self.secondPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.secondPlayer addToCurrentLifeCount: 2];
                    [self displayFloatingCombatTextWithNumber: 2 inView: self.secondPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            case 3:
                if (sgr.direction & (UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight)) {
                    [self.secondPlayer subtractFromCurrentLifeCount: 3];
                    [self displayFloatingCombatTextWithNumber: -3 inView: self.secondPlayerView withColor: [UIColor redColor]];
                } else {
                    [self.secondPlayer addToCurrentLifeCount: 3];
                    [self displayFloatingCombatTextWithNumber: 3 inView: self.secondPlayerView withColor: [UIColor greenColor]];
                }
                
                break;
            default:
                break;
        }
        
        [self syncSecondPlayerModelAndView];
    }
    
    if ([sender isKindOfClass: [UITapGestureRecognizer class]]) {
        // UITapGestureRecognizer * tgr = sender;
        
        [self endTurnSecondPlayer];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    for (UIGestureRecognizer * gr in [self.firstPlayerView gestureRecognizers]) {
        [self.firstPlayerView removeGestureRecognizer: gr];
    }
    
    for (UIGestureRecognizer * gr in [self.secondPlayerView gestureRecognizers]) {
        [self.secondPlayerView removeGestureRecognizer: gr];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void) dealloc {
    [firstPlayerView release];
    [secondPlayerView release];
    [firstPlayer release];
    [secondPlayer release];
    [firstPlayerlabel release];
    [secondPlayerlabel release];
    [firstPlayerStatusLabel release];
    [secondPlayerStatusLabel release];
    [globalStatusLabel release];
    
    [super dealloc];
}
@end
