//
//  DQMissoesJogador.h
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQItensJogador.h"

@interface DQMissoesJogador : NSObject

//Dicionario que armazena as informações da plist missoesReferencia
@property NSMutableArray *arrayDeMissoesReferencia;

//Dicionario que armazena as informações da plist missoesJogador
@property NSMutableArray *arrayDeMissoesJogador;

//DQItensJogador para ter acesso aos ítens do jogador
@property DQItensJogador *itensDoJogador;

//NSString que armazena o índice da missão atual
@property int missaoAtual;

//int que armazena em qual parte da missão atual o jogador está
@property int parteDaMissao;

//Método que faz mudar para a missão passada por parâmetro
-(void)iniciarMissao: (int)missao;

//Método que faz passar a parte da missão quem que está (se for a última parte, chama o método FIMDAMISSAO)
-(void)passarParteMissao;

//Método que mostra características da missão atual
-(void)mostrarMissao;

@end
