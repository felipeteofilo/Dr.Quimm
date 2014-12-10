//
//  DQBackground.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 24/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCoberturaBackground.h"
#import "DQPlataforma.h"
#import "DQEscalavel.h"
#import "DQUteis.h"
#import "DQControleCorpoFisico.h"
#import "DQEscalavel.h"
#import "DQCoberturaBackground.h"
#import "DQFruta.h"

static NSString* NomeNodePlataformas= @"NodeComPlataformas";
@interface DQBackground : SKSpriteNode

@property int fase;
@property int parte;
@property DQCoberturaBackground *cobertura;

-(id)initBackgroundFase:(int)fase parte:(int)parte naPosicao:(CGPoint)posicao infoParte:(NSDictionary*)infoParte;
-(void)criarPlataformas:(NSArray*)arrayPlataformas;
-(void)criaFrutasBackground:(NSArray*)frutasAdd;
-(void)adicionarPlataforma:(SKNode*)plataformaAdd noNode:(SKNode*)nodeAddPlataforma;
-(void)desativaPlataformas:(float)posicaoYJogador;
-(void)criaEscalavel:(NSArray*)arrayEscalaveis;
-(void)criaCoberturaParaBackground;
-(void)escondeCobertura;
-(void)controleAtivacaoPlataforma:(SKNode*)nodePlataforma posicaoJogador:(float)YJogador velocidadeY:(float)velYJogador;
-(void)verificaCoberturaBackground:(CGPoint)posJogadorConvertida;

@end
