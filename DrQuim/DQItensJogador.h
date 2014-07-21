//
//  DQItensJogador.h
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQItensJogador : NSObject

//NSDictionary que armazena quanto de cada item disponível o jogador tem
@property NSMutableDictionary *dicionarioDeItensJogador;

//NSDictionary que armazena a categoria (Arma/Consumível/Missão), nome, descriçao e imagem do item
@property NSMutableDictionary *dicionarioDeItensReferencia;

//Método que adiciona 1 item ao jogador
-(void)receberItem: (NSString *)item quantidade:(int)quantidade;

//Método que tira 1 item do jogador
-(void)entregarItem: (NSString *)item quantidade:(int)quantidade;

//Método que armazena os itens em um NSArray e mostra suas caracteristicas
-(void)mostrarItens;

@end
