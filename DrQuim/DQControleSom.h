//
//  DQControleSom.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 17/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>
#import "DQControleUserDefalts.h"
#import "DQUteis.h"

//Agora o controle de som ficará na viewController,

typedef NS_ENUM(int, TipoObjeto){
    Jogador=0,
    ContadorGeiger=1,
    NPC=3,
};

typedef NS_ENUM(int, TamanhoTexto){
    Pequeno=1,
    Medio=2,
    Grande=3,
};

@interface DQControleSom : NSObject

//Dicionários usados para guardar os sons para o jogador e o NPC
@property NSDictionary *sonsDisponiveisJogador;
@property NSDictionary *sonsDisponiveisNPC;
@property AVAudioPlayer *playerSomJogador;
@property AVAudioPlayer *playerSomNPC;
@property AVAudioPlayer *playerContador;

@end
