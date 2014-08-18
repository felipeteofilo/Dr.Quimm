//
//  DQAnimalCoelho.m
//  criacaoAnimal
//
//  Created by LEONARDO DE SOUSA MENDES on 15/08/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQAnimalCoelho.h"

@implementation DQAnimalCoelho

-(id)initCoelho{
    if (self=[super initAnimalNome:@"Coelho" sprite:@"parado1" raioVisao:50]) {
        self.dirCaminhada='E';
        self.distanciaAndar=50;
        self.tempoAndar=2;
        self.nAcoesVez=5;
        self.distanciaCorrer=300;
        
        
        [self setZPosition:-50.0f];
        [self setPersonalidade:Docil];
        [self.spriteAnimal setScale:0.9f];
        [self listarAcoes];
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.spriteAnimal.frame]];
        [self.physicsBody setDynamic:NO];
    }
    return self;
}

-(void)parar{
    self.acaoAtual=@"parado";
    
    [self pararAnimacao];
    
    [self iniciarAnimacao:@"parado"];
    [self animarAnimal];
}

-(void)fugir{
    //Remove as açoes do animal
    [self removeAllActions];
    
    //limpa a lista de acoes do animal
    [self.acoes removeAllObjects];
    
    [self iniciarAnimacao:@"correndo"];
    [self correr];
}

-(void)andar{
    SKAction *andar;
    
    if (self.dirCaminhada=='D') {
        andar=[SKAction moveByX:self.distanciaAndar y:0 duration:self.tempoAndar];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*-1;
    }else if (self.dirCaminhada=='E'){
        andar=[SKAction moveByX:(self.distanciaAndar * -1) y:0 duration:self.tempoAndar];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*1;
    }
    
    if (andar) {
        self.acaoAtual=@"andar";
        
        [self iniciarAnimacao:@"correndo"];
        [self animarAnimal];
        [self runAction:andar completion:^{
            [self parar];
        }];
    }
    
}
-(void)correr{
    SKAction *correr;
    
    if (self.dirCaminhada=='D') {
        correr=[SKAction moveByX:self.distanciaCorrer y:0 duration:2];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*-1;
    }else if (self.dirCaminhada=='E'){
        correr=[SKAction moveByX:(self.distanciaCorrer * -1) y:0 duration:2];
        
        self.spriteAnimal.xScale = fabs(self.spriteAnimal.xScale)*1;
    }
    
    if (correr) {
        self.acaoAtual=@"fugindo";
        
        [self iniciarAnimacao:@"correndo"];
        [self animarAnimal];
        
        [self runAction:correr completion:^{
            [self parar];
        }];
    }
}
-(void)atacar{
    [self iniciarAnimacao:@"parado"];
    [self runAction:[SKAction performSelector:@selector(animarAnimal) onTarget:self]completion:^{
        [self parar];
    }];
}

-(void)realizarAcao{
    if (![self.spriteAnimal hasActions]) {
        if ([self.acoes count] > 0) {
            [self performSelector:[self seletorProxAcao]];
            
            [self.acoes removeObjectAtIndex:0];
        }else{
            [self rastrearAreaBackground:self.scene];
        }
    }
}
@end
