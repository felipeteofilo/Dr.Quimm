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
    NSMutableArray *framesEscalando;
    NSMutableArray *framesCaindo;
    NSMutableArray *framesDerrapando;
    
}
//Propriedade que armazenará os sprites e animações
@property SKSpriteNode *spriteNode;

//variável int - Define VIDA / FOME / SEDE / RESPEITO ====
@property int vida;
@property int fome;
@property int sede;
@property int respeito;
//========================================================
@property int podePular;
@property BOOL podeEscalar;
@property BOOL estaNoChao;

@property NSString *andandoParaDirecao;


//Função de inicialização
-(id)initJogadorSprite: (NSString*)name;

//Funcao para iniciar os frames das animacoes
-(void)iniciarAnimacoes:(NSDictionary*)animacoes;

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

//funcao para animar jogador caindo
-(void)animarCaindo;

//Método para parar de andar
-(void)pararAndar;

//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(NSString*)direcao;

//funcao para parar a escalada do jogador
-(void)pararEscalar;

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada;
@end
