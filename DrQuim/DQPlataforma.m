//
//  DQPlataforma.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 04/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQPlataforma.h"

@implementation DQPlataforma

-(id)initComY:(float)_maiorY{
    if ([super init]) {
        self.name=nomePlataforma;
        
        self.anchorPoint=CGPointMake(0, 1);
        //Dicionario será usado para analisar o Y do node ao ter o contato com ele
        NSMutableDictionary *dicionarioDadosNode=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithFloat:_maiorY] forKey:nomeMaiorY];
        
        [self setUserData:dicionarioDadosNode];
    }
    return self;
}
@end