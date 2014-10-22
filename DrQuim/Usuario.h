//
//  Usuario.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSNumber * vida;
@property (nonatomic, retain) NSNumber * fome;
@property (nonatomic, retain) NSNumber * sede;
@property (nonatomic, retain) NSNumber * respeito;
@property (nonatomic, retain) id missao;
@property (nonatomic, retain) id itens;
@property (nonatomic, retain) id armadilhas;
@property (nonatomic, retain) NSString * nome;

@end
