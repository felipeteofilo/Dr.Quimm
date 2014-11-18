//
//  DQTelaInfoComposto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQScroolView.h"



@interface DQTelaInfoComposto : UIViewController 

@property DQScroolView *scrollViewElementos;
@property UIView * infoElemento;
@property UIButton * botaoFechar;

-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho nomeComposto:(NSString*)nome;


@end
