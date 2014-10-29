//
//  DQCoreDataController.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCoreDataController.h"

@implementation DQCoreDataController

+(Usuario*)procurarJogador :(NSString*)nome{
    DQAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Usuario"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(nome = %@)",
     nome];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        return nil;
    }
    else{
        return [objects objectAtIndex:0];
    }
}

+(void)salvarVida:(int)vida respeito:(int)respeito fome:(int)fome sede:(int)sede doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setVida:[NSNumber numberWithInt:vida]];
    [newContact setRespeito:[NSNumber numberWithInt:respeito]];
    [newContact setFome:[NSNumber numberWithInt:fome]] ;
    [newContact setSede:[NSNumber numberWithInt:sede]];
    
    
    NSError *erro;
    [context save:&erro];
}
+(void)salvarItens :(NSDictionary*)itens doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
     Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setItens:itens];
    
    
    NSError *erro;
    [context save:&erro];
    
}
+(void)salvarArmadilhas :(NSMutableArray*)armadilhas doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setArmadilhas:armadilhas];
    
    
    NSError *erro;
    [context save:&erro];

}
+(void)salvarMissao:(NSMutableDictionary*)missao doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setMissao:missao];
    
    
    NSError *erro;
    [context save:&erro];
    
}
+(void)salvarFaseAtual:(int)fase parte:(int)parte doJogador:(NSString*)nome{
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setFase:[NSNumber numberWithInt:fase]];
    [newContact setPartefase:[NSNumber numberWithInt:parte]];
    
    
    NSError *erro;
    [context save:&erro];

}
@end
