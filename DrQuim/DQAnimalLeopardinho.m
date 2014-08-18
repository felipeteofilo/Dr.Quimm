//
//  DQAnimalLeopardinho.m
//  criacaoAnimal
//
//  Created by Leonardo de Sousa Mendes on 14/08/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQAnimalLeopardinho.h"

@implementation DQAnimalLeopardinho

-(id)initLeopardinho{DQIsca *isca = [[DQIsca alloc]initIsca:@"Carne" Caracterisca:@"Coelho"];
    if (self=[super initAnimalNome:@"Coelho" sprite:@"parado1" raioVisao:50 Isca:isca]) {
        
        self.distanciaAndar=100;
        self.tempoAndar=2;
        self.dirCaminhada='E';
        
        [self.spriteAnimal setScale:0.9f];
        [self setPersonalidade:Agressivo];
        [self listarAcoes];
    }
    return self;
}

@end
