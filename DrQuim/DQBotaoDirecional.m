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

-(id)initDirecional:(NSString*)imagemBotao seletorHorizontal:(SEL)seletorHorizontal seletorVertical:(SEL)selVertical selSoltarDir:(SEL)soltarDir dalegateSeletores:(id<DQControleProtocoll>)delegate{
    
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

//Verifica se esta movendo em X ou em Y
    //Ambos NO verifica qual a maior alteração

    //Verifica qual processo deve fazer 
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //pega  a posicao do toque atual
    CGPoint posicaoToqueAtual=[[touches anyObject]locationInNode:self];
    
    //Verifica as alteracoes nas posicoes
    float alteracaoX=posicaoToqueAtual.x - self.posicaoToqueInicial.x;
    float alteracaoY=posicaoToqueAtual.y - self.posicaoToqueInicial.y;
    
    //Verifica se ja esta ocorrendo algum movimento
    if (!self.movimentoX && !self.movimentoY) {
        //Das alterações verifica qual é mais forte X ou Y
        if (fabsf(alteracaoX)+5 > fabsf(alteracaoY)) {
            self.movimentoX=YES;
            //Moveu em X nao move em Y
            self.movimentoY=NO;
        }else{
            self.movimentoY =YES;
            self.movimentoX=NO;
        }
    }
    
    //Chama processo ref ao eixo que está movendo
    if (self.movimentoX) {
        [self processaMovimentoHorizontal:alteracaoX];
    }
    
    if (self.movimentoY) {
        [self processaMovimentoVertical:alteracaoY];
    }
}
-(void)processaMovimentoHorizontal:(float)forcaMov{
    //O carinha mexeu mais na horizontal faz o jogador andar
    //Verifica se ja passou do limite de movimentação
    if((self.forcaMovimento >= 0)&&(self.forcaMovimento <= limiteMovimento)) {
        //Pega delta do movimento em X
        self.forcaMovimento =+forcaMov;
    }
        
    if ((self.forcaMovimento <= 0 )&&(self.forcaMovimento >= (limiteMovimento*-1))) {
        self.forcaMovimento =+forcaMov;
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
        [self.delegateBotao performSelector:self.acaoRealizar withObject:[NSNumber numberWithFloat:(self.forcaMovimento/100)]];
    }
}

-(void)processaMovimentoVertical:(float)forcaMov{
    if (self.forcaMovimento <= limiteMovimento) {
        //Pega delta do movimento em X
        self.forcaMovimento =+forcaMov;
    }
    
    if (!self.travaMovDirecional) {
        //Faz botao mecher
        if (self.forcaMovimento > 0) {
            [self setPosition:CGPointMake(self.position.x, self.position.y+forcaMovBotao)];
        }else{
            [self setPosition:CGPointMake(self.position.x, self.position.y-forcaMovBotao)];
        }
    }
    
    //O carinha mexeu mais na vertical faz o jogador escala
    if (fabsf(self.position.y - self.posicaoInicialBotao.y) > 6) {
        self.travaMovDirecional=YES;
    }
    
    //Faz ele escalar
    if ([self.delegateBotao respondsToSelector:self.seletorVertical]) {
        //So preciso mandar se foi positivo ou negativo p escolher entre subir ou descer a escada
        [self.delegateBotao performSelector:self.seletorVertical withObject:[NSNumber numberWithFloat:forcaMov]];
    }
}

//Faz a ação do botão
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //Retorna á posição inicial
    [self setPosition:self.posicaoInicialBotao];
    [self setAlpha:0.2f];
    
    self.travaMovDirecional=NO;
    
    //Avisa que nao esta mexendo em mais nada
    self.movimentoX=NO;
    self.movimentoY=NO;
    
    //Zera a força do Mov
    self.forcaMovimento=0;
    
    if ([self.delegateBotao respondsToSelector:self.selSoltouDirecional]) {
        //So preciso mandar se foi positivo ou negativo p escolher entre subir ou descer a escada
        [self.delegateBotao performSelector:self.selSoltouDirecional];
    }
}

@end
