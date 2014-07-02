//
//  DQJogador.h
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQJogador : SKNode

//SKSpriteNode do jogador
@property SKSpriteNode *spriteJogador;

//SKActions das animações
@property SKAction *acaoAnimarAndando; //KEY:"animacaoAndando"
@property SKAction *acaoAnimarPulando; //KEY:"animacaoPulando"
@property SKAction *acaoAnimarParado; //KEY:"animacaoParado"

//SActions de movimentos
@property SKAction *acaoMovimentoAndar; //KEY:"MovimentoAndando"

//Booleano para saber se está ou não carregando o Cientista
@property BOOL carregandoCientista;

//Booleanos para controlar as ações que estão, ou não, acontecendo.
@property BOOL estaPulando;

//NSString que indica para qual direção o jogador está andando
@property NSString *direcaoAndar;

//Singleton do jogador
+(id)sharedJogador;

//Metodo para iniciar a classe. Chama o método de iniciar o sprite do jogador e o de criar as animações
-(id)init;

//********************************************COISAS A FAZER - LINHA 6!!!
//Metodo que inicia o jogador com phisicsBody e seu tamanho
-(void)iniciaSpriteJogador;


//Método para fazer o jogador pular
-(void)pular;

//Método para fazer o jogador andar para a direção passada
-(void)andarParaDirecao: (NSString *)direcao;

//Método para fazer o jogador parar de andar
-(void)pararDeAndar;


//Método que cria as ações de animação do jogador - Cria SKTextureAtlas para todas as animações, atribui as texturas a um array de frames e por fim, cria os SKActions animados pelos frames contidos nos arrays
-(void)criarAcoesAnimacaoJogador;

//Métodos para realizas as animações. Animar apenas
-(void)animarAndando;
-(void)animarPulando;
-(void)animarParado;

@end
