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
@property NSMutableDictionary *dicionarioDeMissoesReferencia;

//Dicionario que armazena as informações da plist missoesJogador
@property NSMutableDictionary *dicionarioDeMissoesJogador;

//NSString que armazena a key da missão atual
@property NSString *missaoAtual;

//int que armazena em qual parte da missão atual o jogador está
@property int parteDaMissao;

@end
