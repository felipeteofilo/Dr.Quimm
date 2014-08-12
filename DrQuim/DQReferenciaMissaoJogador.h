//
//  DQReferenciaMissaoJogador.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 28/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classe será usada para pegar a missao atual do jogador e montar as informacoes com a missao referencia
@interface DQReferenciaMissaoJogador : NSObject

+(NSDictionary*)detalharMissaoAtual:(int)missao;
+(NSString*)pathArquivoMissoesJogador;
+(NSString*)pathArquivoMissoesReferencia;
+(NSArray*)arquivoPlist:(NSString*)path;
@end