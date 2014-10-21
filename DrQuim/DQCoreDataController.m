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
    [NSEntityDescription entityForName:@"Jogador"
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
    NSManagedObject *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        [newContact setValue:nome forKey:@"nome"];
    }
    
    [newContact setValue:[NSNumber numberWithInt:vida] forKey:@"vida"];
    [newContact setValue:[NSNumber numberWithInt:respeito] forKey:@"respeito"];
    [newContact setValue:[NSNumber numberWithInt:fome] forKey:@"fome"];
    [newContact setValue:[NSNumber numberWithInt:sede] forKey:@"sede"];
    
    
    NSError *erro;
    [context save:&erro];
}
+(void)salvarItens :(NSDictionary*)itens doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        [newContact setValue:nome forKey:@"nome"];
    }
    
    [newContact setValue:itens forKey:@"itens"];
    
    
    NSError *erro;
    [context save:&erro];
    
}
+(void)salvarArmadilhas :(NSMutableArray*)armadilhas doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        [newContact setValue:nome forKey:@"nome"];
    }
    
    [newContact setValue:armadilhas forKey:@"armadilhas"];
    
    
    NSError *erro;
    [context save:&erro];

}
+(void)salvarMissao:(NSMutableDictionary*)missao doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        [newContact setValue:nome forKey:@"nome"];
    }
    
    [newContact setValue:missao forKey:@"missao"];
    
    
    NSError *erro;
    [context save:&erro];
    
}

@end
