//
//  DQMissoesJogador.m
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissoesJogador.h"

@implementation DQMissoesJogador

-(id)init
{
    self = [super init];
    if(self){
        
        //Popula o dicionario de Missoes do jogador
        //url
        NSString *urlMissoesJogador = [[NSBundle mainBundle] pathForResource:@"MissoesJogador" ofType:@"plist"];
        //dicionario
        self.dicionarioDeMissoesJogador = [[NSMutableDictionary alloc]initWithContentsOfFile:urlMissoesJogador];
        
        
        //Popula o dicionario que descreve as Missões
        //url
        NSString *urlMissoesReferencia = [[NSBundle mainBundle] pathForResource:@"MissoesReferencia" ofType:@"plist"];
        //dicionario
        self.dicionarioDeMissoesReferencia = [[NSMutableDictionary alloc]initWithContentsOfFile:urlMissoesReferencia];
        
        //Key da missão atual - inicia na 00 que é sem missão
        self.missaoAtual = [NSString stringWithFormat:@"Missao00"];
        
        //Inicia no 0
        self.parteDaMissao = 0;
        
        NSLog(@"Missão atual: %@", self.missaoAtual);
    }
    return self;
}

-(void)iniciarMissao: (NSString *)missao
{
    [[self.dicionarioDeMissoesJogador objectForKey:self.missaoAtual] setValue:[NSNumber numberWithBool:NO] forKey:@"Atual"];

    //escreve que a missão de agora é a atual
    [[self.dicionarioDeMissoesJogador objectForKey:missao] setValue:[NSNumber numberWithBool:YES] forKey:@"Atual"];
    
    //redefine variaveis da missão
    self.missaoAtual = missao;
    self.parteDaMissao = 0;
}

-(void)passarParteMissao
{
    self.parteDaMissao ++;
    [[self.dicionarioDeMissoesJogador objectForKey:self.missaoAtual] setValue:[NSNumber numberWithInt:self.parteDaMissao] forKey:@"ParteAtual"];
}

@end
