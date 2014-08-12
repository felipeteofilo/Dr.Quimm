//
//  DQJogador.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQItensJogador.h"
#import "DQMissaoControle.h"
#import "DQFalasNoJogoControle.h"

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

//DQItensJogador que armazena tudo relacionado a itens
@property DQItensJogador *itens;

//DQMissoesJogador que armazena tudo relacionado a Missões
@property DQMissaoControle* controleMissoes;

//Aumentar fome do personagem
-(void)aumentarFome:(int)aumento;

//Aumentar sede do personagem
-(void)aumentarSede:(int)aumento;

//Perder Vida
-(void)perderVida:(int)perda;

//Diminuir fome do personagem
-(void)diminuirFome:(int)subtracao;

//Diminuir sede do personagem
-(void)diminuirSede:(int)subtracao;

//Ganha Vida
-(void)aumentarVida:(int)aumento;

//Função de inicialização
-(id)initJogadorSprite: (NSString*)name;

//Funcao para iniciar os frames das animacoes
-(void)iniciarAnimacoes:(NSDictionary*)animacoes;

//Método de retorno VOID - Faz o personagem andar para a direção que foi passada
-(void)andarParaDirecao:(NSString*)direcao;

//Método de retorno VOID - Faz o personagem pular
-(void)pular;

//Método de retorno VOID - Faz o personagem interagir com o NPC
-(void)interagirComNPC:(NSString*)nomeNPC ControleDeFalas:(DQFalasNoJogoControle*)controleDeFalas;

//Metodo para atualizar o status da missao
-(void)atualizarStatusMissao;

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

//funcao para animar o jogador derrapando
-(void)animarDerrapando;

//Método para parar de andar
-(void)pararAndar;

//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(NSString*)direcao;

//funcao para parar a escalada do jogador
-(void)pararEscalar;

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada;

//Funcao para parar de derrapar
-(void)pararDerrapar;
@end
