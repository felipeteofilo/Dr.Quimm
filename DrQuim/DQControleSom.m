//
//  DQControleSom.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 17/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleSom.h"

@implementation DQControleSom

NSError *error;
NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"pew-pew-lei" withExtension:@"caf"];
AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
[player setVolume:masterVolume];
[player prepareToPlay];

SKAction*   playAction = [SKAction runBlock:^{
    [player play];
}];
SKAction *waitAction = [SKAction waitForDuration:player.duration+1];
SKAction *sequence = [SKAction sequence:@[playAction, waitAction]];

[self runAction:groupActions];

-(id)initControleSom:(SKScene*)fase{
    
}
@end
