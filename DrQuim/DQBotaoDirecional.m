//
//  DQBotaoDirecional.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQBotaoDirecional.h"
#define forcaMovBotao 0.5f
#define limiteMovimento 100

@implementation DQBotaoDirecional

-(id)initDirecional:(NSString*)imagemBotao seletorHorizontal:(SEL)seletorHorizontal seletorVertical:(SEL)selVertical selSoltarDir:(SEL)soltarDir dalegateSeletores:(id)delegate{
    
    if (self=[super initBotao:imagemBotao comSel:seletorHorizontal eDelegate:delegate eTamanho:CGSizeMake(100,100)]) {
        
        self.seletorVertical= selVertical;
        self.selSoltouDirecional=soltarDir;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    //pega a posicao do primeiro toque
    self.posicaoToqueInicial=[[touches anyObject]locationInNode:self];
    
    //Pega a posicaoX inicial do botao
    self.posicaoInicialBotao=self.position;
}

//Calcula qnto precisa andar
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //pega  a posicao do toque atual
    CGPoint posicaoToqueAtual=[[touches anyObject]locationInNode:self];
    
    //Verifica as alteracoes nas posicoes
    float alteracaoX=posicaoToqueAtual.x - self.posicaoToqueInicial.x;
    float alteracaoY=posicaoToqueAtual.y - self.posicaoToqueInicial.y;
    
    //Das alterações verifica qual é mais forte X ou Y
    if (fabsf(alteracaoX) > fabsf(alteracaoY)) {
        //O carinha mexeu mais na horizontal faz o jogador andar
        //Verifica se ja passou do limite de movimentação
        if (self.forcaMovimento <= limiteMovimento) {
            //Pega delta do movimento em X
            self.forcaMovimento =+alteracaoX;
        }

        if (!self.travaMovDirecional) {
            //Faz botao mecher
            if (self.forcaMovimento > 0) {
                [self setPosition:CGPointMake(self.position.x+forcaMovBotao, self.position.y)];
            }else{
                [self setPosition:CGPointMake(self.position.x-forcaMovBotao, self.position.y)];
            }
        }
        
        //Cria limite para animação movimento do botao
        if (fabsf(self.position.x - self.posicaoInicialBotao.x) > 6) {
            self.travaMovDirecional=YES;
        }
        
        //Faz ele andar
        if ([self.delegateBotao respondsToSelector:self.acaoRealizar]) {
            [self.delegateBotao performSelector:self.acaoRealizar withObject:[NSNumber numberWithFloat:self.forcaMovimento]];
        }
    }else{
        if (self.forcaMovimento <= limiteMovimento) {
            //Pega delta do movimento em X
            self.forcaMovimento =+alteracaoX;
        }
        
        if (!self.travaMovDirecional) {
            //Faz botao mecher
            if (self.forcaMovimento > 0) {
                [self setPosition:CGPointMake(self.position.x, self.position.y-forcaMovBotao)];
            }else{
                [self setPosition:CGPointMake(self.position.x, self.position.y+forcaMovBotao)];
            }
        }
        
        //O carinha mexeu mais na vertical faz o jogador escala
        if (fabsf(self.position.y - self.posicaoInicialBotao.y) > 6) {
            self.travaMovDirecional=YES;
        }
        
        //Faz ele escalar
        if ([self.delegateBotao respondsToSelector:self.seletorVertical]) {
            //So preciso mandar se foi positivo ou negativo p escolher entre subir ou descer a escada
            [self.delegateBotao performSelector:self.seletorVertical withObject:[NSNumber numberWithFloat:alteracaoY]];
        }
    }
}

//Executa a açao
//Faz a ação do botão
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegateBotao respondsToSelector:self.selSoltouDirecional]) {
        //So preciso mandar se foi positivo ou negativo p escolher entre subir ou descer a escada
        [self.delegateBotao performSelector:self.selSoltouDirecional];
    }
    //Retorna á posição inicial
    [self setPosition:self.posicaoInicialBotao];
    [self setAlpha:0.2f];
    
    self.travaMovDirecional=NO;
}

@end
