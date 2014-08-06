//
//  DQFalasNoJogoControle.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFalasNoJogoControle.h"

@implementation DQFalasNoJogoControle


-(id)initComFaseAtual:(int)faseAtual{
    
    if (self = [super init]) {
        NSString *caminhoArquivo = [[NSBundle mainBundle] pathForResource:@"FalasNoJogo" ofType:@"plist"];
        NSArray *arrayFalas = [NSArray arrayWithContentsOfFile:caminhoArquivo];
        self.dicionarioDeFalas = [[NSMutableDictionary alloc]init];
        self.dicionarioDeFalas = [arrayFalas objectAtIndex:faseAtual -1];
    }
    
    return self;
}
//-(SKNode*)mostrarAlerta :(NSString*)key{
//    self.caixaDeFala =[[DQFala alloc]initComDicionario:]
//}
//-(SKNode*)mostrarFala :(NSString*)npc :(NSString*)keyFala;
//-(SKNode*)proximaFala;
//-(void)fimFala;
@end
