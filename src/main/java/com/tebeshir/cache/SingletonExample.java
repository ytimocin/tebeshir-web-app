/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.cache;

/**
 *
 * @author yeko
 */
public class SingletonExample {

    // Static member holds only one instance of the
    // SingletonExample class
    private static SingletonExample singletonInstance;

    // SingletonExample prevents any other class from instantiating
    private SingletonExample() {
    }

    // Providing Global point of access
    public static synchronized SingletonExample getSingletonInstance() {
        if (null == singletonInstance) {
            singletonInstance = new SingletonExample();
            System.out.println("Creating new instance");
        }
        return singletonInstance;
    }

    public void printSingleton() {
        System.out.println("Inside print Singleton");
    }
    
    public static void main(String[] args) {
        SingletonExample.getSingletonInstance().printSingleton();
        SingletonExample.getSingletonInstance().printSingleton();
        SingletonExample.getSingletonInstance().printSingleton();
        SingletonExample.getSingletonInstance().printSingleton();
        SingletonExample.getSingletonInstance().printSingleton();
    }
}
