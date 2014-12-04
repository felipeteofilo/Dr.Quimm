//
//  DQTelaInfoComposto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQScrollView.h"
#import "MarqueeLabel.h"

@interface DQTelaInfoComposto : UIViewController

@property DQScrollView *scrollViewElementos;
@property UIView * infoElemento;
@property UIButton * botaoFechar;
@property MarqueeLabel *nomeComposto;
@property UIImageView * imagemComposto;
@property UITextView * telaInfo;
@property NSString * ultimoComposto;

-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho nomeComposto:(NSString*)nome;
-(void)atualizarInfoComposto:(NSString*)nome;


@end
