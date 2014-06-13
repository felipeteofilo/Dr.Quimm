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

@interface DQCutsceneView : NSObject

//Armazena as cutscenes do jogo de acordo com a parte passada
@property NSArray *arrayCutscenes;

//Atribui um numero chamado PARTE para organizar as cenas
@property int parte;

//Cria uma string que contem o caminho (path) do arquivo plist de falas
@property NSString *plistFalaPath;

//Cria um NSDictionary com o conteudo da pList.
@property NSArray *arrayDeFalas;

//Inicia com uma parte
-(id)initComParte: (int)parte_;


@end
