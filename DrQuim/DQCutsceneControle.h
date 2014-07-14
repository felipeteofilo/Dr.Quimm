//
//  DQCutsceneView.h
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQCena.h"
#import "DQFala.h"
#import <SpriteKit/SpriteKit.h>

@interface DQCutsceneControle : NSObject

//Propriedade que define a cena atual
@property int cenaAtual;

//SkScene atual do jogo
@property SKScene *cutscene;

//Seletor para iniciar o gameplay da fase
@property SEL iniciarGameplay;

//SKSpritenode que representa o fundo em uma cutscene
@property SKSpriteNode *fundo;

//SKSpritenode da caixa de fala que ira conter as falas
@property SKSpriteNode *caixaDeFala;

//SKLabelNode da instrução (Clique para continuar)
@property SKLabelNode *instrucao;

//SKSpritenode do rosto de quem fala
@property SKSpriteNode *rosto;

//NSArray que armazena as falas em frases
@property NSMutableArray *arrayDefalasEmFrases;

//NSarray que armazena as falas atuais
@property NSArray *falasAtuais;

//Propriedade que define a fala atual
@property int falaAtual;

//Armazena as cutscenes do jogo de acordo com a parte passada
@property NSArray *arrayCutscenes;

//Armazena as Falas de dentro do jogo
@property NSArray *arrayFalasDentroDoJogo;

//Armazena as Falas da fase Atual
@property NSMutableDictionary * falasDoJogo;

//Armazena as falas do jogo de acordo com a parte passada
@property NSMutableArray *arrayFalas;

//Armazena as cenas do jogo de acordo com a parte passada
@property NSMutableArray *arrayCenas;

//Atribui um numero chamado PARTE para organizar as cenas
@property int parte;

//Atribui um numero para a fase atual
@property int faseAtual;

//Cria uma string que contem o caminho (path) do arquivo plist de falas
@property NSString *plistFalaPath;

//Cria um NSArray com o conteudo da pList.
@property NSArray *arrayDeFalasPLists;

@property NSDictionary *dicionarioDeFalasNPC;

//Inicia com uma parte
-(id)initComParte:(int)parte Fase:(int)fase;

//Inicia as falas adicionando-as, dependendo da parte, no arrayFalas e no arrayCenas;
-(void)iniciaFalas;

//Metodo que inicia uma cutscene
-(void)iniciarCutscene :(SKScene*)cena Seletor:(SEL)seletor;

//Metodo para trocar de Cutscene
-(void)trocarCena;

//Metodo para mostrar falas In Game
-(void)mostrarFalaNoJogo :(SKScene*)cena KeyDaFala:(NSString*)key;

//Metodo que retorna se pode trocar a fala ou nao
-(BOOL)trocarFala;

@end
