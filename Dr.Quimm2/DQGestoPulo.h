//
//  DQGestoPulo.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQGestoPulo : UISwipeGestureRecognizer 

//Metodo para iniciar a classe
-(id)init;

//Metodo para executar o pulo do jogador após fazê-lo parar de andar
-(void)pular;

@end
