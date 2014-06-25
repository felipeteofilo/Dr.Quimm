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

@interface DQCutsceneControle : NSObject

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

//Cria um NSDictionary com o conteudo da pList.
@property NSArray *arrayDeFalasPLists;

//Inicia com uma parte
-(id)initComParte:(int)parte_ Fase:(int)fase;

//Inicia as falas adicionando-as, dependendo da parte, no arrayFalas e no arrayCenas;
-(void)iniciaFalas;

@end
