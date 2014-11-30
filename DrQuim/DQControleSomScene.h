//
//  DQControleSomScene.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleSom.h"

typedef NS_ENUM(int, TipoCena){
    Fase=0,
    CutScene=1,
};

@interface DQControleSomScene : DQControleSom

@property AVAudioPlayer *playerMusicaFundo;

@property (atomic)int indiceCena;
@property (atomic)TipoCena tipoCena;

@property NSDictionary *sonsDisponiveisScene;
//Aqui terei o nome do animal e som correspondente
@property NSDictionary *sonsDisponiveisAnimais;

@property AVAudioPlayer *playerMusicaCena;
@property AVAudioPlayer *playerEfeitoCena;
@property AVAudioPlayer *playerAnimal;


-(id)initControleSomCena;

-(void)tocarMusicaFundo;

@end
