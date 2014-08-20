//
//  DQControleReceita.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQControleReceita.h"

@implementation DQControleReceita
+(NSString*)pathArquivoReceitas{
    
    return  [[NSBundle mainBundle] pathForResource:@"Receitas" ofType:@"plist"];
}

+(NSArray*)arquivoPlist:(NSString*)path{
    return [[NSArray alloc]initWithContentsOfFile:path];
}

+(NSArray*)receitasConfiguradas{
    NSArray *arrayRetorno=[NSArray arrayWithContentsOfFile:[self pathArquivoReceitas]];
    
    if([arrayRetorno count] == 0){
        return nil;
    }
    
    return arrayRetorno;
}

+(NSDictionary*)detalheReceita:(int)nReceita{
    NSMutableDictionary *dictionarioRetorno=[[self receitasConfiguradas]objectAtIndex:nReceita];
    
    return dictionarioRetorno;
}
@end
