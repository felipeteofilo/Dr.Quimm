//
//  DQFasesControle.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 24/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "DQCutsceneTela.h"

@interface DQFasesControle : NSObject


@property NSArray *fases;

-(void)mudarDeFase :(int)fase Scene:(SKScene*)scene;
+(id)sharedFasesControle;
-(void)mudarDeFase:(int)fase Scene:(SKScene *)scene idCutScene:(int)idCutScene;
@end
