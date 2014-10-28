//
//  MovimentoProtocoll.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 23/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

@protocol DQControleProtocoll <NSObject>

@required
-(void)escaladaPersonagem:(NSNumber*)valorMovimento;
-(void)movimentaPersonagem:(NSNumber*)forcaMovimento;
-(void)pararPersonagem;
-(void)puloPersonagem;

@end