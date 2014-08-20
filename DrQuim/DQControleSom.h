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

typedef NS_ENUM(int, TipoObjeto){
    Jogador=0,
    ContadorGeiger=1,
    NPC=3,
};

@interface DQControleSom : SKNode

@property AVAudioPlayer *playerSom;
@property NSArray * listaSons;
@property int indiceSomTocar;
@property TipoObjeto tipoObjeto;

-(void)tocarSom;
-(int)sortearSomTocar;
-(void)tocarSom:(AVAudioPlayer*)player;
-(void)proxSom;
-(id)initControleSom:(TipoObjeto)objetoControlado;
-(AVAudioPlayer*)configuraPlayerSom:(NSString*)nomeSomTocar;
-(AVAudioPlayer*)configuraPlayerSom:(NSString*)nomeSomTocar nLoops:(int)nLoops;
-(void)tocarSomLista;
-(void)tocarSomLooping:(AVAudioPlayer*)player;
-(void)pararSom;
@end
