//
//  DQElemento.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQElemento.h"

@implementation DQElemento


-(id)initComEntidadeElemento:(Elemento*)elemento{
    
    if(self  = [super initWithImageNamed:elemento.imagem]){
        
        self.nome = elemento.nome;
        self.numeroEletrons = elemento.n_eletrons.intValue;
    }
    
    
    return self;
}


@end
