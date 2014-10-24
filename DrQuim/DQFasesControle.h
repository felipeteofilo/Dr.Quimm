//
//  DQFasesControle.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 24/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface DQFasesControle : NSObject


@property NSArray *fases;

-(SKScene*)mudarDeFase :(int)fase Size:(CGSize)size;
+(id)sharedFasesControle;

@end
