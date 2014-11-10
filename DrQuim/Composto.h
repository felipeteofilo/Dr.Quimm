//
//  Composto.h
//  DrQuim
//



//  Created by Leonardo de Sousa Mendes on 06/11/14.

//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <CoreData/CoreData.h>


@interface Composto : NSManagedObject

@property (nonatomic, retain) NSString * formula_molecular;
@property (nonatomic, retain) NSString * imagem;
@property (nonatomic, retain) id info_Composto;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSOrderedSet *elementos_composto;
@end

@interface Composto (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inElementos_compostoAtIndex:(NSUInteger)idx;
- (void)removeObjectFromElementos_compostoAtIndex:(NSUInteger)idx;
- (void)insertElementos_composto:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeElementos_compostoAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInElementos_compostoAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceElementos_compostoAtIndexes:(NSIndexSet *)indexes withElementos_composto:(NSArray *)values;
- (void)addElementos_compostoObject:(NSManagedObject *)value;
- (void)removeElementos_compostoObject:(NSManagedObject *)value;
- (void)addElementos_composto:(NSOrderedSet *)values;
- (void)removeElementos_composto:(NSOrderedSet *)values;
@end

@interface dictionaryInfo : NSValueTransformer

@end