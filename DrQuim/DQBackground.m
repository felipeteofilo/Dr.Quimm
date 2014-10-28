//
//  DQBackground.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 24/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQBackground.h"

@implementation DQBackground
-(id)initBackgroundFase:(int)fase parte:(int)parte naPosicao:(CGPoint)posicao infoParte:(NSDictionary*)infoParte{
    if (self=[super initWithImageNamed:[NSString stringWithFormat:@"Fase%i_Parte%i",fase,parte]]) {
        [self setAnchorPoint:CGPointZero];
        [self setZPosition:-100.0];
        [self setPosition:posicao];
        
        //Define o corpo Físico
        [self setPhysicsBody:[DQControleCorpoFisico criaCorpoFisicoChao:[infoParte objectForKey:@"CorpoFisicoChao"]]];
        
        [self chaoCategoria];
    }
    return self;
}

#pragma mark Controle de Plataformas
-(void)criarPlataformas:(NSArray*)arrayPlataformas{
    //[[self infoParteFase:parte]objectForKey:@"Plataformas"];
    
    SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parte daFase:self.fase CGFrameTela:self.frame ArrayPlataforma:arrayPlataformas];
    
    [plataforma setName:NomeNodePlataformas];
    
    [self adicionarPlataforma:plataforma noNode:self];
}

-(void)adicionarPlataforma:(SKNode*)plataformaAdd noNode:(SKNode*)nodeAddPlataforma{
    if (plataformaAdd) {
        for (DQPlataforma *plataforma in [plataformaAdd children]) {
            [self plataformaDesativadaCategoria:plataforma];
        }
        
        [nodeAddPlataforma addChild:plataformaAdd];
    }
}

-(void)controleAtivacaoPlataforma:(SKNode*)nodePlataforma posicaoJogador:(float)YJogador velocidadeY:(float)velYJogador{
    float yPlataforma =[[nodePlataforma.userData objectForKey:nomeMaiorY]floatValue] + 00.0f;
    
    //Verifica se jogador esta abaixo da plataforma que colidiu
    if (YJogador < yPlataforma ) {
        [self plataformaAtivadaCategoria:nodePlataforma];
        
    }else if((velYJogador <= 0) && (YJogador > yPlataforma )){
        [self plataformaAtivadaCategoria:nodePlataforma];
    }
}

-(void)desativaPlataformas:(float)posicaoYJogador{
    //Se tiver um node com plataformas
    if ([self childNodeWithName:NomeNodePlataformas]) {
        
        //Para cada node plataforma no Node que contem as plataformas verificar
        for (SKNode *plataforma in [[self childNodeWithName:NomeNodePlataformas]children]) {
            if ([[plataforma.userData objectForKey:nomeMaiorY]floatValue] > posicaoYJogador) {
                //Evita ficar chamando toda hora
                if (!(plataforma.physicsBody.categoryBitMask & PlataformaAtivadaCategoria)!=0) {
                    [self plataformaDesativadaCategoria:plataforma];
                }
            }
        }
    }
}

#pragma mark Escalavel e Cobertura de background
-(void)criaEscalavel:(NSArray*)arrayEscalaveis{
    //Adiciona escada caso tenha
    if (![self childNodeWithName:nomeEscalavel]){
        for (int i=0;i<[arrayEscalaveis count];i++) {
            
            //Cada posicao no array de escalaveis tem apenas 2 posicoes (Ponto inicial e ponto Final do escalavel)
            CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
            CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
            
            //cria a escada e seta o corpo fisico dela
            DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
            
            [self escadaCategoria:escada];
            [self addChild:escada];
        }
    }
}

-(void)criaCoberturaParaBackground{
    DQCoberturaBackground *coberturaBackground=[[DQCoberturaBackground alloc]initCoberturaParte:self.parte daFase:self.fase];
    
    if (coberturaBackground) {
        [self addChild:coberturaBackground];
    }
}

-(void)verificaCoberturaBackground:(CGPoint)posJogadorConvertida{
    DQCoberturaBackground *cobetura=(DQCoberturaBackground*)[self childNodeWithName:NomeNodeCobertura];
    
    if ([cobetura.name isEqualToString:NomeNodeCobertura]) {
        [cobetura manipulaCobertura:posJogadorConvertida];
    }
}

-(void)escondeCobertura{
    
}

#pragma mark Configuracao corpos Fisicos
-(void)chaoCategoria{
    //Chao Categoria
    self.physicsBody.categoryBitMask=ChaoCategoria;
    self.physicsBody.collisionBitMask=JogadorCategoria;
    self.physicsBody.contactTestBitMask=JogadorCategoria;
    self.physicsBody.usesPreciseCollisionDetection=YES;
}
-(void)escadaCategoria:(SKNode*)node{
    node.physicsBody.categoryBitMask=EscadaCategoria;
    node.physicsBody.collisionBitMask=0;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}
-(void)plataformaDesativadaCategoria:(SKNode*)node{
    //Chao Categoria
    node.physicsBody.categoryBitMask=PlataformaDesativadaCategoria;
    node.physicsBody.collisionBitMask=0;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}
-(void)plataformaAtivadaCategoria:(SKNode*)node{
    //Chao Categoria
    node.physicsBody.categoryBitMask=PlataformaAtivadaCategoria;
    node.physicsBody.collisionBitMask=0;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}
@end
