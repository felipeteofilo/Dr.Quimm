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


{
    //Armazena as cutscenes do jogo
    NSMutableArray * cutscenes;
}



//Atribui um numero chamado PARTE para organizar as cenas
@property int parte;


//Metodo para armazenar as cenas
-(void)armazenaCenas;

//Metodo para armazenar as falas
-(void)armazenaFalas;

@end
