//
//  DQBotaoDirecional.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQBotaoDirecional.h"
#define forcaMovBotao 0.5f

@implementation DQBotaoDirecional

-(id)initDirecional:(NSString*)imagemBotao seletorHorizontal:(SEL)seletorHorizontal seletorVertical:(SEL)selVertical dalegateSeletores:(id)delegate{

    if (self=[super initBotao:imagemBotao comSel:seletorHorizontal eDelegate:delegate eTamanho:CGSizeMake(100,100)]) {
        
        self.seletorVertical= selVertical;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    //pega a posicao do primeiro toque
    self.posicaoToqueInicial=[[touches anyObject]locationInNode:self.parent];
    
    //Pega a posicaoX inicial do botao
    self.xInicialBotao=self.position.x;
}

//Calcula qnto precisa andar
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //pega  a posicao do toque atual
    CGPoint posicaoToqueAtual=[[touches anyObject]locationInNode:self.parent];
    
    //Pega delta do movimento em X
    //TODO: Arrumar conversão valores
    self.forcaMovimento =posicaoToqueAtual.x - self.posicaoToqueInicial.x;
    
    //TODO: decidir se moveu o Y ou X

    if (!self.travaMovDirecional) {
        //Faz botao mecher
        if (self.forcaMovimento > 0) {
            [self setPosition:CGPointMake(self.position.x+forcaMovBotao, self.position.y)];
        }else{
            [self setPosition:CGPointMake(self.position.x-forcaMovBotao, self.position.y)];
        }
    }
    
    //TODO: Animar alteração em Y
    //Cria limite para animação movimento do botao
    if (fabsf(self.position.x - self.xInicialBotao) > 6) {
        self.travaMovDirecional=YES;
    }
}

//Executa a açao
//Faz a ação do botão
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegateBotao respondsToSelector:self.acaoRealizar]) {
        [self.delegateBotao performSelector:self.acaoRealizar withObject:[NSNumber numberWithFloat:self.forcaMovimento]];
    }
    
    //Retorna á posição inicial
    [self setPosition:CGPointMake(self.xInicialBotao, self.position.y)];
    
    [self setAlpha:0.2f];
    
    self.travaMovDirecional=NO;
}

@end
