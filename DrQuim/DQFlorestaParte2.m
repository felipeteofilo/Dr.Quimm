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
    [self posicionarAnimais];
}

-(void)salvarCenaVila :(SKScene*)vila{
    self.vila =vila;
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

//-(void)apitarRadiacao:(NSString*)nomeArquivoAudio{
//    if (![self actionForKey:@"apitar"]) {
//        [self.hudFase.contador setarNivelPerigo:3];
//        SKAction *apitar=[SKAction playSoundFileNamed:nomeArquivoAudio waitForCompletion:YES];
//        SKAction *parar=[SKAction removeFromParent];
//
//        [self runAction:[SKAction sequence:@[apitar,parar]]withKey:@"apitar"];
//    }
//}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
    [self falarAlertaRadiacao];
    
    if (![self childNodeWithName:@"falasDoJogo"] && [self.jogador.controleMissoes.missao.ID isEqual:@"Missao02"] && self.jogador.controleMissoes.parteAtual == 3) {
        
        [self.view presentScene:self.vila];
    }
}

@end
