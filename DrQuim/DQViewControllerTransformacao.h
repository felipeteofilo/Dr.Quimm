//
//  DQViewControllerTransformacao.h
//  DrQuim
//
//  Created by Felipe Teofilo on 11/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "DQCoreDataController.h"
#import "DQTelaTransformacao.h"



@interface DQViewControllerTransformacao : UIViewController



@property NSString *receita;

-(id)initWithReceita:(NSString*)receita;
@end
