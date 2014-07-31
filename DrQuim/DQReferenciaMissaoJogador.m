//
//  DQReferenciaMissaoJogador.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 28/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQReferenciaMissaoJogador.h"

@implementation DQReferenciaMissaoJogador

+(NSString*)pathArquivoMissoesJogador{
    
    return  [[NSBundle mainBundle] pathForResource:@"MissoesJogador" ofType:@"plist"];
}
+(NSString*)pathArquivoMissoesReferencia{
    return  [[NSBundle mainBundle] pathForResource:@"MissoesReferencia" ofType:@"plist"];
}

+(NSArray*)arquivoPlist:(NSString*)path{
    return [[NSArray alloc]initWithContentsOfFile:path];
}

+(NSDictionary*)detalharMissaoAtual:(int)missao {
    NSDictionary *missaoJogador=[[self arquivoPlist:[self pathArquivoMissoesJogador]]objectAtIndex:missao];
    NSNumber *parteAtual=[missaoJogador objectForKey:@"ParteAtual"];
    
    //Usando cast para permiti manipulacao do dicionario
    NSMutableDictionary *missaoRetorno=[NSMutableDictionary dictionaryWithDictionary:[[self arquivoPlist:[self pathArquivoMissoesReferencia]]objectAtIndex:missao]];
    
    NSDictionary *detalhesParte=[[missaoRetorno objectForKey:@"Partes"]objectAtIndex:[parteAtual intValue]-1];

    //Deixar apenas a parte atual
    [missaoRetorno removeObjectForKey:@"Partes"];
    
    [missaoRetorno setObject:[detalhesParte objectForKey:@"Objetivo Atual"]  forKey:@"Objetivo Atual"];
    [missaoRetorno setObject:[detalhesParte objectForKey:@"Descricao"]  forKey:@"Descricao"];

    return missaoRetorno;
}

@end
