//
//  DQTexto.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQConfigMenu.h"

//Classe será usada para a apresentação de texto qubrando linhas
//A propria classe sera um node a ser adicionado
static NSString* nomeTexto=@"texto";
@interface DQTexto : SKSpriteNode

@property NSArray *labelstexto;

-(id)initTexto:(NSString *)texto espacoLimite:(CGSize)espacoLimite fonte:(float)fonte;
-(id)initTexto:(NSString *)texto espacoLimite:(CGSize)espacoLimite fonte:(float)fonte anchorPoint:(CGPoint)anchorPoint;
-(void)mudaCorTexto:(UIColor*)cor;

-(void)alinhaTextoHorizontal:(SKLabelHorizontalAlignmentMode)alinhamento;
-(void)alinhaTextoVertical:(SKLabelVerticalAlignmentMode)alinhamento;
@end
