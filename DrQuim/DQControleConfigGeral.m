//
//  DQControleConfigGeral.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 30/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleConfigGeral.h"

@implementation DQControleConfigGeral

+(NSDictionary*)arquivoPlist{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FalasNoJogo" ofType:@"plist"]];
}

+(BOOL)precisaAtualizarFasesCoreData{
    return [[[DQControleConfigGeral arquivoPlist]objectForKey:@"AtualizarFasesCoreData"]boolValue];
}
@end
