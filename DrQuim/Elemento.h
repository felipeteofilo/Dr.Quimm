//
//  Elemento.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Elemento : NSManagedObject

@property (nonatomic, retain) NSString * imagem;
@property (nonatomic, retain) id info_elemento;
@property (nonatomic, retain) NSNumber * n_eletrons;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * simbolo;

@end

@interface dictionaryInformacoes : NSValueTransformer

@end