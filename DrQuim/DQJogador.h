//
//  DQJogador.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQJogador : SKSpriteNode


//Arrays que guardam os frames das animacoes do jogador
{
    NSMutableArray *framesAndando;
    NSMutableArray *framesPulando;
    NSMutableArray *framesParado;
}



//variável int - Define a vida do jogador
@property int vida;

//variável int - Define a fome do jogador
@property int fome;

//variável int - Define a sede do jogador
@property int sede;

//variável int - Define o respeito do jogador
@property int respeito;

@property int podePular;


//Método de retorno VOID - Faz o personagem andar para a direção que foi passada
-(void)andarParaDirecao:(NSString*)direcao;

//Método de retorno VOID - Faz o personagem pular
-(void)pular;

//Método de retorno VOID - Faz o personagem interagir
-(void)interagir;

//Singleton do jogador
+(id)sharedJogador;

//Metodo para animar o jogador andando
-(void)animarAndando;

//Metodo para animar o jogador pulando
-(void)animarPular;

//Metodo para animar o jogador parado
-(void)animarParado;

@end
