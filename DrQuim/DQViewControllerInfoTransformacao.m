//
//  DQViewControllerInfoTransformacao.m
//  DrQuim
//
//  Created by Felipe Teofilo on 11/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQViewControllerInfoTransformacao.h"

@interface DQViewControllerInfoTransformacao ()

@end

@implementation DQViewControllerInfoTransformacao

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImageView *fundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fundoTransformacao"]];
    
    [fundo setFrame:self.view.bounds];
    
    [self.view addSubview:fundo];
    
    DQPopularCoreData *core = [[DQPopularCoreData alloc]init];
    
    [core iniciarReferenciasTransformacoes];
    
    //Array temporarios - substitui pela array de compostos que o jogador possui
    NSArray *arrayDeCompostos = [[NSArray alloc]initWithObjects:@"Ácido Sulfúrico", @"Açúcar (Sacarose)", @"Glicerina", @"Permanganato de potássio", @"Nitrato de chumbo II", @"Sulfato de potássio", @"Iodeto de Potássio", @"Nitrato de Potássio", @"Sulfato de Magnésio", @"Cloreto de sódio",@"Nitrato de Chumbo", nil];
    int numeroDeCompostos = arrayDeCompostos.count;
    
    
    
    DQcirculo *circulo = [[DQcirculo alloc]initComFrame:CGRectMake(0, 0, self.view.bounds.size.height * 0.5, self.view.bounds.size.height * 0.5) comDelegate:self comNumeroDeCompostos:numeroDeCompostos eCompostos:arrayDeCompostos];
    
    circulo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:circulo];
    
    [circulo mostrarInfoComposto];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
