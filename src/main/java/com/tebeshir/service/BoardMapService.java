/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tebeshir.service;

import com.tebeshir.cache.TebeshirCache;
import com.tebeshir.entity.Board;
import com.tebeshir.service.db.BoardMapDBOperations;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

/**
 *
 * @author yeko
 */

// şimdilik iptal

@Lazy
@Scope("singleton")
@Service
public class BoardMapService {
    
    @Autowired
    TebeshirCache tebeshirCache;
    
    @Autowired
    BoardMapDBOperations boardMapDBOperations;
    /*
    public ArrayList<Board> getBoardMap() {
        ArrayList<Board> boardMap = null;
        if (tebeshirCache.isHazelcastInstanceUp()) {
            boardMap = getBoardMapFromCache();
        } else {
            boardMap = getBoardMapFromDB();
        }
        return boardMap;
    }
    */

    private ArrayList<Board> getBoardMapFromCache() {
        return new ArrayList(tebeshirCache.getBoardMapCache().values());
    }

    private ArrayList<Board> getBoardMapFromDB() {
        return boardMapDBOperations.getBoardMap();
    }
    
}
