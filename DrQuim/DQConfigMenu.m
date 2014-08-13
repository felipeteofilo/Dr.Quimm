//
//  DQConfigMenu.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 26/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQConfigMenu.h"

@implementation DQConfigMenu
+(NSDictionary*)arquivoPlist{
    /*
     - Acessa o arquivo plist,
     - acessa o dicinário com as configurações da fase na posicao do array ROOT, usando o parametro _fase como ref.
     - do dicionário acessado pega o array com as partes
     */
    NSString *pathArquivoPlist=[[NSBundle mainBundle]pathForResource:@"ConfigMenu" ofType:@"plist"];
    
    //Verifica se tem fase configurada
    return [NSDictionary dictionaryWithContentsOfFile:pathArquivoPlist];
}

+(NSString*)fonteMenu{
    NSString *stringRetorno=[[self arquivoPlist]objectForKey:@"Fonte"];
    
    if (stringRetorno.length==0){
        return stringRetorno=@"ArialMT";
    }
    
    return stringRetorno;
}

+(NSArray*)opcoesMenuPrincial{
    return [[self arquivoPlist]objectForKey:@"MenuPrincipal"];
}
@end
