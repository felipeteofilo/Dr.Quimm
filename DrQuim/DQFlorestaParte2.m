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
    self.vila =vila;
}

-(void)configuraAnimaisParte{
    
}
-(void)posicionarAnimais{
    DQAnimalLeopardinho * leopardo = [[DQAnimalLeopardinho alloc]initLeopardinho];
    
    [leopardo setPosition:CGPointMake(6120, 475)];
    [leopardo setAnchorPoint:CGPointZero];
    
    leopardo.spriteAnimal.xScale = fabs(leopardo.spriteAnimal.xScale)*-1;
    
    [self.mundo addChild:leopardo];
}

-(void)falarAlertaRadiacao{
    //cria os pontos de menssagem
    CGPoint pontoAlertaRadiacao;
    
    //inicia-os com suas coordenadas
    //-> alerta Radicao Leopardinho
    pontoAlertaRadiacao = CGPointMake(5700, 400);
    
    if (self.jogador.controleMissoes.parteAtual == 2) {
        
        
        
        if ((self.jogador.position.x > pontoAlertaRadiacao.x - RAIOAPITAR  && self.jogador.position.x < pontoAlertaRadiacao.x + RAIOAPITAR) && self.jogador.position.y > pontoAlertaRadiacao.y - 10 ){
            
            [self atualizarPerigoContador];
            
            //-> alerta alpha
            if(self.jogador.position.x > pontoAlertaRadiacao.x  && self.jogador.position.x < pontoAlertaRadiacao.x+100 && self.jogador.position.y >= pontoAlertaRadiacao.y -20 && !self.falouRadiacaoLeopardinho){
                
                
                //inicia a fala
                NSString *keyDaFala = @"RadiacaoLeopardinho";
                
                [self addChild:[self.controleDeFalas mostrarAlertaComKey:keyDaFala Tamanho:self.size]];
                self.jogador.controleMissoes.parteAtual++;
                [self.direcional removeFromParent];
                self.falouRadiacaoLeopardinho =YES;
                [self.jogador pararAndar];
            }
        }
    }
}

-(void)atualizarPerigoContador{
    [self.hudFase.contador setarNivelPerigo:3];
}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
    [self falarAlertaRadiacao];
    
    if (![self childNodeWithName:@"falasDoJogo"] && [self.jogador.controleMissoes.missao.ID isEqual:@"Missao02"] && self.jogador.controleMissoes.parteAtual == 3) {
        
        [self.view presentScene:self.vila];
    }

//TODO:- Melhorar Método
    //Verifica se: esta na missao03, nao esta falando e ja tem o coelho
    if (([self.jogador.controleMissoes.missao.ID isEqualToString:@"Missao03"])&&(self.jogador.controleMissoes.parteAtual==4)) {
        
        if ([self.jogador estaComItem:@"Coelho"]) {
            //Esta na missao 3, e tem o coelho passa a parte da missao e volta p vila
            
            self.jogador.controleMissoes.parteAtual++;
            [self.view presentScene:self.vila];
        }

    }
}

@end
