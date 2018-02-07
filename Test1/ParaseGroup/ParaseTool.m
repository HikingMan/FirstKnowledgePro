//
//  ParaseTool.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/31.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "ParaseTool.h"
#import <objc/message.h>

@implementation ParaseTool

+(instancetype)parasemodel:(NSString *)modelName withSource:(NSDictionary *)sourceDict{

    id model = [NSClassFromString(modelName) new];
    
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(modelName), &count);
    
    for (int i=0; i<count; i++){
        
        objc_property_t property = properties[i];
        
        
        NSString *proName = [NSString stringWithUTF8String:property_getName(property)];
        
        
        unsigned int outCount =0;
        objc_property_attribute_t *proAttri = property_copyAttributeList(property, &outCount);
        
        
        NSString *attriValue = [NSString stringWithUTF8String:proAttri->value];
    
        if([attriValue rangeOfString:@"<"].location != NSNotFound && [attriValue rangeOfString:@">"].location != NSNotFound){
            
            NSString *attriType = [[attriValue componentsSeparatedByString:@"<"] firstObject];
            
            attriValue = [[attriValue componentsSeparatedByString:@"<"] lastObject];
            
            
            attriValue = [[attriValue componentsSeparatedByString:@">"] firstObject];
            
            if([attriType hasSuffix:@"NSArray"] || [attriType hasSuffix:@"NSMutableArray"]){
                
                NSArray *array = [sourceDict objectForKey:proName];
                NSMutableArray * resultArray = [[NSMutableArray alloc]init];
                for(int sub=0;sub<array.count;sub++){
                    
                   id finalModel = [ParaseTool parasemodel:attriValue withSource:[array objectAtIndex:sub]];
                    [resultArray addObject:finalModel];
                }
                
                [model setValue:resultArray forKey:proName];
            }else{
                
                id finalmodel = [ParaseTool parasemodel:attriValue withSource:[sourceDict objectForKey:proName]];
                [model setValue:finalmodel forKey:proName];
                
            }
            
            
            
            
        }else{
            
              [model setValue:[sourceDict objectForKey:proName] forKey:proName];
            
        }
        
    }
    return model;
}

@end
