//
//  DQFlorestaParte2.m
//  DrQuim
//
//  Created by Julia Yamamoto on 30/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte2.h"

#define RAIOAPITAR 180

@implementation DQFlorestaParte2

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:3];
    }
    return self;
}

-(void)iniciarFase
{
    [super iniciarFase];
    if([self.jogador.controleMissoes.missao.ID isEqualToString:@"Missao02"]){
        [self posicionarAnimais];
    }
}

-(void)salvarCenaVila :(SKScene*)vila{
    self.vila = vila;
}

-(void)posicionarAnimais{
    DQAnimalLeopardinho * leopardo = [[DQAnimalLeopardinho alloc]initLeopardinho];
    
    [leopardo setPosition:CGPointMake(6120, 475)];
    [leopardo setAnchorPoint:CGPointZero];
    
    leopardo.spriteAnimal.xScale = fabs(leopardo.spriteAnimal.xScale) * -1;
    
    [self.mundo addChild:leopardo];
}

//-(void)falarAlertaRadiacao{
//    //cria os pontos de menssagem
//    CGPoint pontoAlertaRadiacao;
//    
//    //inicia-os com suas coordenadas
//    //-> alerta Radicao Leopardinho
//    pontoAlertaRadiacao = CGPointMake(5700, 400);
//    
//    if (self.jogador.controleMissoes.parteAtual == 2) {
//
//        if ((self.jogador.position.x > pontoAlertaRadiacao.x - RAIOAPITAR  && self.jogador.position.x < pontoAlertaRadiacao.x + RAIOAPITAR) && self.jogador.position.y > pontoAlertaRadiacao.y - 10 ){
//            
//            [self atualizarPerigoContador];
//        }
//    }
//}

-(void)atualizarPerigoContador{
    [self.hudFase.contador setarNivelPerigo:3];
}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
//    [self falarAlertaRadiacao];
}

@end
