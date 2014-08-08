//
//  DQControleCorpoFisico.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQPlataforma.h"
#import "DQConfiguracaoFase.h"

@interface DQControleCorpoFisico : SKNode


+(SKPhysicsBody*)criaCorpoFisicoChaoParte: (int)_parte daFase:(int)_fase;
+(SKPhysicsBody*)criaCorpoFisicoChao:(NSArray*)arrayPosicoes;
+(SKNode*)criarPlataformaParte: (int)_parte daFase:(int)_fase CGFrameTela:(CGRect)_rectTela;
+(SKNode*)criarPlataformaParte:(int)_parte daFase:(int)_fase CGFrameTela:(CGRect)_rectTela ArrayPlataforma:(NSArray*)plataformasConfig;
@end
