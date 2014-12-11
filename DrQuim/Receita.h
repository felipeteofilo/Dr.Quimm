//
//  Receita.h
//  DrQuim
//
//  Created by Felipe Teofilo on 11/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Receita : NSManagedObject

@property (nonatomic, retain) id compostos;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * id_item_gerar;
@property (nonatomic, retain) id info_conf_composto;
@property (nonatomic, retain) id ligacoes;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * resultado;
@property (nonatomic, retain) id elementos;
@property (nonatomic, retain) NSNumber * numero_ligacoes;

@end
