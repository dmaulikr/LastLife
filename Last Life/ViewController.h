//
//  ViewController.h
//  Last Life
//
//  Created by Ken Hung on 10/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerLifeCounter.h"

@interface ViewController : UIViewController {
    NSInteger activePlayer;
}

@property (nonatomic, retain) IBOutlet UIView * firstPlayerView, * secondPlayerView;
@property (nonatomic, retain) IBOutlet UILabel * firstPlayerlabel, * secondPlayerlabel, * firstPlayerStatusLabel, * secondPlayerStatusLabel, *globalStatusLabel;
@property (nonatomic, retain) PlayerLifeCounter * firstPlayer, * secondPlayer;

- (IBAction) resetGame: (id)sender;
- (IBAction) showCoinFlip: (id) sender;
@end
