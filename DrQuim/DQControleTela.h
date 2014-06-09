//
//  DQControleTela.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 29/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>


//TELA USADA TEMPORARIAMENTE PARA DEFINIR OQUE TERÁ NO TELA(FRAME) DE CUTSCENE - falas, imagem etc;

@interface DQControleTela : NSObject

//Método com retorno UIImage que pegará o ID da tela e retornará a imagem que deve aparecer na mesma
+(UIImage*)imagemTela: (int)idTela;

//Método com retorno NSArray, que usará o ID da tela para retornar as falas da mesma
+(NSArray*)falasTela: (int)idTela;

@end
