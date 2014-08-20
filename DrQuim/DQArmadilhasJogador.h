//
//  DQArmadilhasJogador.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQArmadilhasJogador : NSObject


//NSMutableArray que guarda as armadilhas do jogador 
@property NSMutableArray *arrayDeArmadilhasJogador;

//NSDictionary que armazena a categoria (Arma/Consumível/Missão), nome, descriçao e imagem do item
@property NSMutableDictionary *dicionarioDeArmadilhasReferencia;

//Método que adiciona armadilhas ao jogador
-(void)receberArmadilha: (NSString *)armadilha;

//Retorna um array com todos as armadilhas do jogador
-(NSArray*)arrayArmadilhasJogador;
@end
