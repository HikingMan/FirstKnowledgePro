//
//  TestListNode.cpp
//  Test1
//
//  Created by Wang HongLu on 2018/6/5.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#include "TestListNode.hpp"
#include <iostream>
#include <string.h>
#include <stack>

using namespace std;

//单链表的反转
struct ListNode{
    
    
//    当前节点的值
    int m_nValue;
    
    //下一个节点的指针
    ListNode *m_pNext;
};



ListNode * ReverseList(ListNode* head){
    
    ListNode *pNode = head;
    
    ListNode *pPrev = NULL;
    
    while (pNode != NULL) {
        
        
        // 保存当前节点指向的下一个节点的指针，防止链表断开
        ListNode *pNext = pNode->m_pNext;
        
        //当前节点的next指针，指向前一个节点
        pNode->m_pNext = pPrev;
        
        //前一个节点后移
        pPrev = pNode;
        //当前节点后移,变成指向的next；
        pNode = pNext;
    }
    
    return pPrev;
}


//二叉树的遍历

struct TreeNode{
    
    //当前节点的内容（当前节点作为根节点）
    char data;
    
    //左节点
    struct TreeNode *leftTreeNode;
    
    //右节点
    struct TreeNode *rightTreeNode;
    
};
//https://www.cnblogs.com/SHERO-Vae/p/5800363.html
//递归

void travesal(TreeNode *root){
    
//    前序遍历（根节点，左子树，右子树）
    if(root != NULL){
      
        cout<<root->data<<" ";
        travesal(root->leftTreeNode);
        travesal(root->rightTreeNode);
    }
    
//     中序遍历（左子树，根节点，右子树）
    if(root != NULL){
        
        travesal(root->leftTreeNode);
        cout<<root->data<<" ";
        travesal(root->rightTreeNode);
    }
//    后序遍历（左子树，右子树，根节点）
    if(root != NULL){
        
        travesal(root->leftTreeNode);
        travesal(root->rightTreeNode);
        cout<<root->data<<" ";
        
    }
    
}


//非递归

void traversal2 (TreeNode *root) {
    
    stack<TreeNode *> sta;
    TreeNode *p = root;
    
    while (p != NULL || !sta.empty()) {
        
        while(p != NULL){
            
            //输出
            cout<<p->data<<" ";
            //进栈
            sta.push(p);
            //指向左节点
            p = p->leftTreeNode;
            
        }//这里第一次执行完，根节点和所有左节点进栈
        
        if(!sta.empty()){
//            区栈顶元素，即最后添加的左节点
            p = sta.top();
            sta.pop();
            p = p->rightTreeNode;//指向右节点，之后把每个右节点作为根节点继续寻找左节点和右节点；
        }
        
    }
    
}






