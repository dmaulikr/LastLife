//
//  PlayerLifeCounter.h
//  Last Life
//
//  Created by Ken Hung on 10/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultValues.h"

@interface PlayerLifeCounter : NSObject {
    NSInteger maxLifeCount;
}

@property (nonatomic, assign) NSInteger currentLifeCount;
- (id) initWithLifeCount: (NSInteger) life;

- (BOOL) didPlayerLose;

- (void) resetLifeCount;
- (void) subtractFromCurrentLifeCount: (NSInteger) amountToSubtract;
- (void) addToCurrentLifeCount: (NSInteger) amountToAdd;
@end
