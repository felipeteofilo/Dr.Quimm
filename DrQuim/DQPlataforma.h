//
//  DQPlataforma.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 04/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//#define nomePlataforma @"Plataforma"

static NSString* nomePlataforma = @"Plataforma";
static NSString* nomeMaiorY = @"maiorY";

@interface DQPlataforma : SKSpriteNode

-(id)initComY:(float)_maiorY;
@end
