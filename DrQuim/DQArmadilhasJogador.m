//
//  DQArmadilhasJogador.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQArmadilhasJogador.h"

@implementation DQArmadilhasJogador


-(id)init
{
    self = [super init];
    if(self){
        
        //array de armadilhas
        self.arrayDeArmadilhasJogador = [[NSMutableArray alloc]init];
        
        
        //Popula o dicionario que descreve as armadilhas
        //url
        NSString *urlItensReferencia = [[NSBundle mainBundle] pathForResource:@"ArmadilhasReferencia" ofType:@"plist"];
        //dicionario
        self.dicionarioDeArmadilhasReferencia = [[NSMutableDictionary alloc]initWithContentsOfFile:urlItensReferencia];
        
        //[self receberArmadilha:@"ArmadilhaSimples"];
        
        
    }
    return self;
}

//Método que adiciona armadilhas ao jogador
-(void)receberArmadilha: (NSString *)armadilha {
    
    [self.arrayDeArmadilhasJogador addObject:armadilha];
}

//Retorna um array com todos as armadilhas do jogador
-(NSArray*)arrayArmadilhasJogador{
    return self.arrayDeArmadilhasJogador;
}

@end
