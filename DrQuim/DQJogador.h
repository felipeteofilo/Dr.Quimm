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
#import "DQControleUserDefalts.h"
#import "DQArmadilhasJogador.h"
#import "DQControleSom.h"
#import "DQUteis.h"
#import "DQCoreDataController.h"

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

@property BOOL podeEscalar;
@property BOOL estaNoChao;

@property float distAndar;
@property int impulsoPulo;

@property NSString *andandoParaDirecao;

@property DQControleSom *controleSom;

//DQItensJogador que armazena tudo relacionado a itens
@property DQItensJogador *itens;

//DQArmadilhasJogador que armazena tudo relacionado a Armadilhas
@property DQArmadilhasJogador *armadilhas;

//DQMissoesJogador que armazena tudo relacionado a Missões
@property DQMissaoControle* controleMissoes;

//Metodo que altera a fome do jogador
-(void)alterarFomeJogador: (int)fome;

//Metodo que altera a fome do jogador
-(void)alterarSedeJogador: (int)sede;

//Metodo que altera a fome do jogador
-(void)alterarVidaJogador: (int)vida;

//Função de inicialização
-(id)initJogadorSprite: (NSString*)name;

//Funcao para iniciar os frames das animacoes
-(void)iniciarAnimacoes:(NSDictionary*)animacoes;

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

//funcao para parar a escalada do jogador
-(void)pararEscalar;

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada;

//Funcao para parar de derrapar
-(void)pararDerrapar;

-(void)interagirComNPC:(NSString *)nomeNPC;

//Metodo para verificar se esta com qualquer item passado no parametro
-(BOOL)estaComItem:(NSString*)nomeItem;

//Metodo que verifica se ja esta com contador
-(BOOL)estaComContadorGeiger;

//Método de retorno VOID - Faz o personagem andar para a direção que foi passada
-(void)andarParaDirecao:(char)direcao eDistancia:(float)distancia;
//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(char)direcao;
@end
