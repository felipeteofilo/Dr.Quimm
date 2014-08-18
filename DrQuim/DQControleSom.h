//
//  DQControleSom.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 17/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>
#import "DQControleUserDefalts.h"

@interface DQControleSom : SKNode

@property NSArray * listaSons;
@property int indiceSomTocar;

-(void)tocarSom;
-(int)sortearSomTocar;
+(void)tocarSom:(NSString*)nomeSomTocar;
@end
