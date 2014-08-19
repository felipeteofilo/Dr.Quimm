//
//  DQMenuInicial.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 10/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQConfigMenu.h"
#import "DQControleUserDefalts.h"
#import "DQCutsceneTela.h"
#import "DQFase.h"
#import "DQVila.h"
#import "DQFlorestaParte1.h"

@interface DQMenuInicial : SKScene

@property SKLabelNode *mensagemCarregando;
@property SKSpriteNode *imagemFrasco;

-(void)iniciarJogo;
@end
