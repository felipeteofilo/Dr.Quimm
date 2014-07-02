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

//Metodo para iniciar a classe
-(id)init{
    //inicia com o seletor do metodo pulo da propria classe DQGestoPulo
    if(self = [super initWithTarget:self action:@selector(pular)]){
    
        //Define que o gesto de reconhecimendo é o 'swipe' para cima
        [self setDirection:UISwipeGestureRecognizerDirectionUp];
        
    }
    return self;
}

//Metodo para executar o pulo do jogador após fazê-lo parar de andar
-(void)pular{
    [[DQJogador sharedJogador]pararDeAndar];
    [[DQJogador sharedJogador]pular];
}

@end
