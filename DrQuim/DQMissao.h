//
//  DQMissao.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQMissao : NSObject

@property NSString *nome;
@property NSString *disparador;
@property NSString *recompensa;
@property int respeito;
@property NSArray *arrayPartes;
@property int quantidadeDePartes;
@property NSString *ID;

-(id)initMissao :(int)missao;
-(Boolean)podePassarComNPC :(NSString*)nomeNPC Item:(NSString*)item;
-(Boolean)podeIniciarComNPC :(NSString*)nomeNPC;

@end
