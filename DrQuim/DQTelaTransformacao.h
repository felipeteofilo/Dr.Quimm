//
//  DQTelaTransformacao.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCoreDataController.h"

@interface DQTelaTransformacao : SKScene

@property NSMutableArray* lugaresAnteriores;

-(id)initWithSize:(CGSize)size :(NSArray*)elementos :(Receita*)receita;


@end
