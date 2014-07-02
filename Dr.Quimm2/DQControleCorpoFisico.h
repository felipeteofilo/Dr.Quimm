//
//  DQControleCorpoFisico.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQControleCorpoFisico : SKNode

//Metodo para iniciar a classe
+(SKPhysicsBody*)criaCorpoFísicoBase: (int)parte;
@end
