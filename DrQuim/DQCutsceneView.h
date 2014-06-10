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

//Armazena as falas da cutScene
@property NSMutableArray *arrayDeFalas;

//Armazena as cenas da cutScene
@property NSMutableArray *arrayDeCenas;

//Atribui um numero chamado PARTE para organizar as cenas
@property int parte;

//Init com PARTE que representa a ordem das cutScenes
-(id)initComParte: (int)parte_;

@end
