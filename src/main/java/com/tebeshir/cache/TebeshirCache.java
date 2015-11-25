/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tebeshir.cache;

import com.hazelcast.config.Config;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.IMap;
import com.tebeshir.entity.Board;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

/**
 *
 * @author yeko
 */

// şimdilik iptal

@Lazy(false)
@Scope("singleton")
@Repository
public class TebeshirCache implements TebeshirCacheKeys {
    
    @Autowired
    private HazelcastInstance hazelcastInstance;
    
    private boolean isHazelcastInstanceUp;
    
    public HazelcastInstance getInstance() {
        Config config = new Config();
        config.setInstanceName("tebeshir-main");
        HazelcastInstance instance = Hazelcast.getHazelcastInstanceByName("tebeshir-main");
        if (instance == null) {
            instance = Hazelcast.newHazelcastInstance(config);
        }
        return instance;
    }
    /*    
    @PostConstruct
    private void initDistributedCacheContainer() {
        hazelcastInstance = getInstance();
        isHazelcastInstanceUp = true;
    }
    */
    
    public IMap<Object, Board> getBoardMapCache() {
        return hazelcastInstance.getMap(BoardMap);
    }

    public boolean isHazelcastInstanceUp() {
        return isHazelcastInstanceUp;
    }
    
}
