//
//  DQMissoesJogador.h
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQMissoesJogador : NSObject

//Dicionario que armazena as informações da plist missoesReferencia
@property NSMutableArray *arrayDeMissoesReferencia;

//Dicionario que armazena as informações da plist missoesJogador
@property NSMutableArray *arrayDeMissoesJogador;

//NSString que armazena o índice da missão atual
@property int missaoAtual;

//int que armazena em qual parte da missão atual o jogador está
@property int parteDaMissao;

@end
