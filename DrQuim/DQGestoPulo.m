//
//  DQGestoPulo.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQGestoPulo.h"
#import "DQJogador.h"

@implementation DQGestoPulo


//Metodo de inicializacao do gesto
-(id)init{
   
    //inicia ele com o seletor do metodo pulo da propria classe
    if(self = [super initWithTarget:self action:@selector(pular)]){
        
        
        //seta que a direcao para ser reconhecido e para cima
        [self setDirection:UISwipeGestureRecognizerDirectionUp];
        
        
    }
    return self;
}

//Metodo para executar o pulo do jogador
-(void)pular{
    
    // Pega o singleton do jogador e o faz pular
    [[DQJogador sharedJogador] pular];
    
    
    //remove as acoes de andar e animandoAndar
    [[DQJogador sharedJogador]  removeActionForKey:@"andar"];
    [[DQJogador sharedJogador]removeActionForKey:@"animandoAndando"];
}





@end
