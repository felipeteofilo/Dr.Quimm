//
//  DQMapaMundiController.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMapaMundiControle.h"

@implementation DQMapaMundiControle

-(id)init{
    if (self=[super init]) {
        self.fasesConfiguradas=[DQCoreDataController pegarTodasFases];
    }
    
    return self;
}

-(BOOL)faseDisponivel:(int)fase{
    return NO;
}

-(void)verificaItem{
    
}

-(void)verificaMissaoConcluida{
    
}

-(void)verificaRespeito{
    
}

+(void)populaCoreData{
    NSArray *arrayFasesConfiguradas=[DQConfiguracaoFase arquivoPlist];
    int nFaseCoreData=[DQCoreDataController nFasesCoreData];
    
    if (nFaseCoreData != [arrayFasesConfiguradas count]) {
        //Para cada registro no plist eu pego os requisitos e subo no coreData
        for (int i=0; i<[arrayFasesConfiguradas count]; i++) {
            //Verifica se ja tem a fase adicionada se nao tiver adiciona
            //+1 adicionado para ajustar o ID com o index do array
            if (![DQCoreDataController procurarFase:i+1]) {
                [DQCoreDataController novaFaseID:i+1 comRequisitos:[DQConfiguracaoFase requisitosFase:i+1]];
            }
        }
    }
}

@end
