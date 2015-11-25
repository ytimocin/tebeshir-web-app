/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tebeshir.entity;

import java.util.ArrayList;

/**
 *
 * @author yeko
 */

// iptal

public class Board {
    
    private int boardID;
    private String boardName;
    private boolean isLeaf;
    private ArrayList<Integer> branches;

    public int getBoardID() {
        return boardID;
    }

    public void setBoardID(int boardID) {
        this.boardID = boardID;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public boolean isIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public ArrayList<Integer> getBranches() {
        return branches;
    }

    public void setBranches(ArrayList<Integer> branches) {
        this.branches = branches;
    }
    
}
