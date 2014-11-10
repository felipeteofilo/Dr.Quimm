//
//  Receita.h
//  DrQuim
//

//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.

//  Created by Leonardo de Sousa Mendes on 06/11/14.

//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>


@interface Receita : NSManagedObject

@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * id_item_gerar;
@property (nonatomic, retain) id info_conf_composto;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSOrderedSet *composto_receita;
@end

@interface Receita (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inComposto_receitaAtIndex:(NSUInteger)idx;
- (void)removeObjectFromComposto_receitaAtIndex:(NSUInteger)idx;
- (void)insertComposto_receita:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeComposto_receitaAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInComposto_receitaAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceComposto_receitaAtIndexes:(NSIndexSet *)indexes withComposto_receita:(NSArray *)values;
- (void)addComposto_receitaObject:(NSManagedObject *)value;
- (void)removeComposto_receitaObject:(NSManagedObject *)value;
- (void)addComposto_receita:(NSOrderedSet *)values;
- (void)removeComposto_receita:(NSOrderedSet *)values;
@end

@interface arrayInfoConfigComposto : NSValueTransformer

@end

