//
//  DQControleCorpoFisico.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQPlataforma.h"

@interface DQControleCorpoFisico : SKNode

//+(SKPhysicsBody*)criaCorpoFísicoBase: (int)parte;
+(SKPhysicsBody*)criaCorpoFisicoChaoParte: (int)_parte daFase:(int)_fase;
+(SKSpriteNode*)criarPlataformaParte: (int)_parte daFase:(int)_fase CGFrameTela:(CGRect)_rectTela;
@end
