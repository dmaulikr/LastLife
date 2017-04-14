//
//  PlayerLifeCounter.m
//  Last Life
//
//  Created by Ken Hung on 10/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerLifeCounter.h"

@interface PlayerLifeCounter (Private)

@end

@implementation PlayerLifeCounter
@synthesize currentLifeCount;

- (id) init {
    if (self = [self initWithLifeCount: STANDARD_LIFE_COUNT]) {
        
    }
    
    return self;
}

- (id) initWithLifeCount: (NSInteger) lifeCount {
    if (self = [super init]) {
        self->maxLifeCount = lifeCount;
        self.currentLifeCount = lifeCount;
    }
    
    return self;
}

- (BOOL) didPlayerLose {
    return self.currentLifeCount <= 0;
}

- (void) resetLifeCount {
    self.currentLifeCount = self->maxLifeCount;
}

- (void) subtractFromCurrentLifeCount: (NSInteger) amountToSubtract {
    self.currentLifeCount -= amountToSubtract;
}

- (void) addToCurrentLifeCount: (NSInteger) amountToAdd {
    self.currentLifeCount += amountToAdd;
}

@end
