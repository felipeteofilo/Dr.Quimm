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

//Seletor p fazer a escalada
@property SEL seletorVertical;
@end
