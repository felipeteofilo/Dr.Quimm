//
//  DQControleSomScene.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleSom.h"
#import "DQConfiguracaoFase.h"
#import "DQCutsceneControle.h"

typedef NS_ENUM(int, TipoCena){
    Fase=0,
    CutScene=1,
};

@interface DQControleSomScene : DQControleSom

@property AVAudioPlayer *playerMusicaFundo;
@property NSString *musicaFundo;
@property int indiceScene;
@property TipoCena tipoCena;

//Aqui terei o nome do animal e som correspondente
@property NSDictionary *sonsDisponiveisAnimais;


@property AVAudioPlayer *playerMusicaFase;
@property AVAudioPlayer *playerEfeitoFase;
@property AVAudioPlayer *playerAnimal;

-(id)initControleSomFundo:(TipoCena)tipoCena nomeSom:(NSString*)somFundo indiceCena:(int)idCena;
-(void)tocarMusicaFundo;
@end
