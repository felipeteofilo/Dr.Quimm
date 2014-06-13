//
//  DQFala.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

//init com SUJEITO que fala e TEXTO do que fala
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_
{
    self = [super init];
    if(self)
    {
        self.sujeito = sujeito_;
        self.texto = texto_;
    }
    return self;
}

//Método de retorno VOID que mostra a fala na tela
-(void)desenhaNaTela
{
    
}

@end
