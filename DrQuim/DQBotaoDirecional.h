//
//  DQBotaoDirecional.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQBotao.h"

@interface DQBotaoDirecional : DQBotao

@property CGPoint posicaoToqueInicial;
@property CGPoint posicaoInicialBotao;
@property float forcaMovimento;
@property BOOL travaMovDirecional;

//Boleanos p decidir se aumenta em X ou Y
@property BOOL movimentoX;
@property BOOL movimentoY;

//Seletor p fazer a escalada
@property SEL seletorVertical;

//Qndo o jogador tirar o dedo do direcional
@property SEL selSoltouDirecional;

@property SKSpriteNode *botaoDirecional;

-(id)initDirecional:(NSString*)imagemBotao seletorHorizontal:(SEL)seletorHorizontal seletorVertical:(SEL)selVertical selSoltarDir:(SEL)soltarDir dalegateSeletores:(id)delegate;
@end
