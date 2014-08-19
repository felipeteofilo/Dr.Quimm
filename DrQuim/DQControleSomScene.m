//
//  DQControleSomScene.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//
#define NSONSAMBIENTE 5

#import "DQControleSomScene.h"

@implementation DQControleSomScene

-(id)initControleSomFundo:(TipoCena)tipoCena nomeSom:(NSString*)somFundo indiceCena:(int)idCena{
    if (self=[super init]) {
        self.musicaFundo=somFundo;
        self.indiceScene=idCena;
        self.tipoCena=tipoCena;
        
        //Verifica se nao esta na fase da vila para preencher os sons de animais da floresta
        if ((self.tipoCena == Fase) && (idCena!=2)) {
            self.listaSons=[self configuraListaEfeitosSonoros];
        }
        
        if ([self.musicaFundo length]!=0) {
            self.playerMusicaFundo =[self configuraMusicaFundo:somFundo];
        }else{
            self.playerMusicaFundo =nil;
        }
        
    }
    return self;
}

-(AVAudioPlayer*)configuraMusicaFundo:(NSString*)nomeSomTocar{
    NSError *error;
    
    NSURL *urlSom = [[NSBundle mainBundle] URLForResource:nomeSomTocar withExtension:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSom error:&error];
    
    NSLog(@"volume som: %f",[DQControleUserDefalts volumeMusica]);
    [player setVolume:[DQControleUserDefalts volumeMusica]];
    [player setNumberOfLoops:-1];
    [player prepareToPlay];
    
    return player;
}

-(void)tocarMusicaFundo{
    if (self.playerMusicaFundo) {
        [self.playerMusicaFundo play];
    }
}
-(NSArray*)configuraListaEfeitosSonoros{
    NSMutableArray *listaSons=[NSMutableArray array];
    NSArray *sonsDisponiveis=[NSArray arrayWithObjects:@"Fundo01 - Passaros ",@"Fundo03 - Animal ",@"Fundo05 - Insetos",@"Fundo07 - Sapos ",@"Fundo08 - Vento ", nil];
    
    int valorSorteado;
    
    for (int i=0; i < NSONSAMBIENTE; i++) {
        valorSorteado=arc4random()%NSONSAMBIENTE;
        
        [listaSons addObject:[sonsDisponiveis objectAtIndex:valorSorteado]];
    }
    
    return listaSons;
}
@end
