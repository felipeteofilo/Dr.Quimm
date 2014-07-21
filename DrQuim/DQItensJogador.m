//
//  DQItensJogador.m
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQItensJogador.h"

@implementation DQItensJogador

-(id)init
{
    self = [super init];
    if(self){
        
        //Popula o dicionario de itens que o jogador possui a partir das informações recebidas pelo arquivo plist
        //url
        NSString *urlItensJogador = [[NSBundle mainBundle] pathForResource:@"ItensJogador" ofType:@"plist"];
        //dicionario
        self.dicionarioDeItensQuantidade = [[NSDictionary alloc]initWithContentsOfFile:urlItensJogador];
        
        
        //Popula o dicionario de itens que descreve todos os itens a partir das informações recebidas pelo arquivo plist
        //url
        NSString *urlItensReferencia = [[NSBundle mainBundle] pathForResource:@"ItensReferencia" ofType:@"plist"];
        //dicionario
        self.dicionarioDeItensQuantidade = [[NSDictionary alloc]initWithContentsOfFile:urlItensReferencia];
        
    }
    return self;
}

@end
