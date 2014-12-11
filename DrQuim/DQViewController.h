//
//  DQViewController.h
//  DrQuim
//

//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "DQMenuInicial.h"
#import "DQCutsceneTela.h"
#import "DQcirculo.h"

#import "DQControleSom.h"
#import "DQControleSomScene.h"

#import "DQViewControllerInfoTransformacao.h"



@interface DQViewController : UIViewController

@property DQControleSom *controleSomEfeitos;
@property DQControleSomScene *controleSomScenes;

@end
