//
//  DQMissao.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQMissao : NSObject


//Variaveis do tipo NSString que guardam as informacoes da missao
@property NSString *nome;
@property NSString *disparador;
@property NSString *recompensa;
@property NSArray *arrayPartes;
@property NSString *ID;


//Variavel do tipo int que guarda o quanto de respeito sera guanho na missao
@property int respeito;

//Varialvel do tipo int que guarda a quantidade de partes essa missao terá
@property int quantidadeDePartes;


//Metodo para iniciar uma missao passando qual o numero da missao
-(id)initMissao :(int)missao;


//Metodo que retorna um boolean informando se pode ser passada a parte atual ou ja esta no fim da missao
-(Boolean)podePassarComNPC :(NSString*)nomeNPC Item:(NSString*)item Parte:(int)parte;

//Metodo que retorna um boolean informando se pode iniciar a missao ou nao
-(Boolean)podeIniciarComNPC :(NSString*)nomeNPC;

@end
