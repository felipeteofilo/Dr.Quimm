//
//  DQConfiguracaoFase.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 05/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQConfiguracaoFase.h"

@implementation DQConfiguracaoFase


+(NSArray*)configParte: (int)_parte daFase:(int)_fase{
    /*
     - Acessa o arquivo plist,
     - acessa o dicinário com as configurações da fase na posicao do array ROOT, usando o parametro _fase como ref.
     - do dicionário acessado pega o array com as partes
     */
    
    NSString *pathArquivoPlist=[[NSBundle mainBundle]pathForResource:@"ConfigFase" ofType:@"plist"];
    
    //Verifica se tem fase configurada
    if ([[NSArray arrayWithContentsOfFile:pathArquivoPlist]count]==0) {
        return nil;
    }
    
    //Verifica se a fase procurada esta dentro do limites do array
    if ((_fase-1 < 0) || (_fase-1 > [[NSArray arrayWithContentsOfFile:pathArquivoPlist]count] )) {
        return nil;
    }
    
    NSArray *configParteFase=[[[NSArray arrayWithContentsOfFile:pathArquivoPlist]objectAtIndex:_fase-1]objectForKey:@"Partes"];
    
    
    return configParteFase;
}
@end
