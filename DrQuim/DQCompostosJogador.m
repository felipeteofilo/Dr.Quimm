//
//  DQCompostosJogador.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 18/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCompostosJogador.h"

@implementation DQCompostosJogador

-(void)receberComposto:(NSString*)composto quantidade:(int)quantidade{
    
    int quantidadeFinal = quantidade;
    
    //Soma a quantidade á quantidadeAtual
    
    if ([self.compostos objectForKey:composto]) {
        int quantidadeAtual = [[self.compostos objectForKey:composto] intValue];
        quantidadeFinal = quantidadeAtual + quantidade;
    }
    
    
    //escrever no dicionario a nova quantidade e o item
    [self.compostos setObject:[NSNumber numberWithInt:quantidadeFinal] forKey:composto];
}
-(void)perderComposto:(NSString*)composto quantidade:(int)quantidade{
   
    //Subtrai a quantidade á quantidadeAtual
    int quantidadeAtual = [[self.compostos objectForKey:composto] intValue];
    int quantidadeFinal = quantidadeAtual - quantidade;
    
    //escrever no dicionario de itens jogador
    [self.compostos setValue:[NSNumber numberWithInt:quantidadeFinal] forKey:composto];
    
    if ([[self.compostos valueForKey:composto]intValue] <= 0) {
        [self.compostos removeObjectForKey:composto];
    }
}
-(NSArray*)arrayCompostosJogador{
    NSArray *arrayRetorno=[[NSArray alloc]initWithArray:[self.compostos allKeys]];
    
    return arrayRetorno;
}



@end
