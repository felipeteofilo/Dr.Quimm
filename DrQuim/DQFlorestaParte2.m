//
//  DQFlorestaParte2.m
//  DrQuim
//
//  Created by Julia Yamamoto on 30/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte2.h"

@implementation DQFlorestaParte2

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:3];
        
        self.hudFase = [[DQHudController alloc]initHud];
        [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
    
        //Inicia com a fase 3
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:3];
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        [self iniciarFase];
        [self addChild:self.hudFase];
    }
    return self;
}

-(void)iniciarFase
{
    [super iniciarFase];
}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *toque = [touches anyObject];
    CGPoint posToque = [toque locationInNode:self.backgroundAtual];
    
    //Pega o node de escada na posicao do toque
    SKNode *nodeTocado = [self.backgroundAtual nodeAtPoint:posToque];
    
    //verifica para onde o jogador deve escalar
    if ([nodeTocado.name isEqualToString:nomeEscalavel]) {
        //Verifica se o Y é maior ou menor
        
        if (posToque.y > (self.jogador.position.y + 20.0)) {
            //Fazer jogador escalar - Subindo
            [self.jogador escalarParaDirecao:@"C"];
            
        }else if (posToque.y < (self.jogador.position.y - 20.0)){
            //Fazer jogador escalar - Descendo
            [self.jogador escalarParaDirecao:@"B"];
        }
        
    }
    
    //Se estiver falando em jogo...
    else if(self.estaFalando){
        if ([self.controleCutscenes trocarFala]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:nil];
            
        }
        else{
            
            self.estaFalando = NO;
            self.cutsceneEstaRodando = NO;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //Ao parar o toque, pausa sua escalada se ainda estiver escalando
    if ([self.jogador actionForKey:@"escalar"]) {
        [self.jogador pausarEscalada];
    }
}

@end
