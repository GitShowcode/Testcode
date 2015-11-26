//
//  Gencare.h
//  Banner_ Foundation
//
//  Created by jiapeixin on 15/11/25.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#ifndef Gencare_h
#define Gencare_h

#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]

#define IMAGE(A) [UIImage imageNamed:A]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#endif /* Gencare_h */
