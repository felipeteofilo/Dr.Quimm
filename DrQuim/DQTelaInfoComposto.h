//
//  DQTelaInfoComposto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DQTelaInfoComposto : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>


-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho nomeComposto:(NSString*)nome;

@end
