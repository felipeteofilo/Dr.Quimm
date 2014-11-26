//
//  Receita.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 26/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Receita : NSManagedObject

@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * id_item_gerar;
@property (nonatomic, retain) id info_conf_composto;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) id compostos;

@end
