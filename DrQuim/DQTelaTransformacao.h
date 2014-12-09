//
//  DQTelaTransformacao.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCoreDataController.h"

static const UInt32 ElementoCategoria = 0x1 << 0;
static const UInt32 ParedesCategoria = 0x1 << 1;


@interface DQTelaTransformacao : SKScene <SKPhysicsContactDelegate>

@property NSMutableArray *lugaresAnteriores;
@property SKSpriteNode *nodeTocado;
@property CGPoint posicaoDelta;


-(id)initWithSize:(CGSize)size :(NSArray*)elementos :(Receita*)receita;


@end
