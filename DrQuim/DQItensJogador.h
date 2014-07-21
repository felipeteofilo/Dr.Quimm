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
@property NSDictionary *dicionarioDeItensQuantidade;

//NSDictionary que armazena a categoria (Arma/Consumível/Missão), nome, descriçao e imagem do item
@property NSDictionary *dicionarioDeItensDescricao;

@end
