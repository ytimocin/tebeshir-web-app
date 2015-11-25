/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.cache;

import com.hazelcast.config.Config;
import com.hazelcast.core.DistributedObject;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.IMap;
import com.tebeshir.classes.Board;
import com.tebeshir.classes.Post;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author yeko
 */
public class PostCache {

    private static IMap<Integer, ArrayList<Post>> posts;
    private static IMap<Integer, ArrayList<Board>> boards;
    private static Post post = new Post();
    private static Board board = new Board();

    public HazelcastInstance getInstance() {
        Config config = new Config();
        config.setInstanceName("tebeshir-main");
        HazelcastInstance instance = Hazelcast.getHazelcastInstanceByName("tebeshir-main");
        if (instance == null) {
            instance = Hazelcast.newHazelcastInstance(config);
        }
        return instance;
    }

    public IMap<Integer, ArrayList<Post>> getAllPosts() throws InstantiationException, IllegalAccessException, SQLException {
        HazelcastInstance hazelcastInstance = getInstance();
        posts = hazelcastInstance.getMap("posts");
        if (posts.isEmpty()) {
            ArrayList<Post> postsFromDB = post.getAllMessagesOfThisBoard(17);
            for (Post postFromDB : postsFromDB) {
                if (posts.get(postFromDB.getMainBoardID()) == null) {
                    ArrayList<Post> tempList = new ArrayList<>();
                    tempList.add(postFromDB);
                    posts.put(postFromDB.getMainBoardID(), tempList);
                } else {
                    ArrayList<Post> tempList = posts.get(postFromDB.getMainBoardID());
                    tempList.add(postFromDB);
                    posts.put(postFromDB.getMainBoardID(), tempList);
                }
            }
        }

        return posts;
    }

    public ArrayList<Post> getPostsOfThisBoard(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        HazelcastInstance hazelcastInstance = getInstance();
        posts = hazelcastInstance.getMap("posts");
        if (posts.isEmpty()) {

            ArrayList<Post> postsFromDB = post.getAllMessagesOfThisBoard(17);
            for (Post postFromDB : postsFromDB) {
                if (posts.get(postFromDB.getMainBoardID()) == null) {
                    ArrayList<Post> tempList = new ArrayList<>();
                    tempList.add(postFromDB);
                    posts.put(postFromDB.getMainBoardID(), tempList);
                } else {
                    ArrayList<Post> tempList = posts.get(postFromDB.getMainBoardID());
                    tempList.add(postFromDB);
                    posts.put(postFromDB.getMainBoardID(), tempList);
                }
            }
        }

        ArrayList<Integer> boardLeaves = new ArrayList<>();
        boardLeaves = board.getBoardLeaves(boardID);

        try {
            if (boardLeaves.isEmpty()) {
                return posts.get(boardID);
            } else {
                ArrayList<Post> returnList = new ArrayList<>();
                for (Integer x : boardLeaves) {
                    if (posts.get(x) != null) {
                        returnList.addAll(posts.get(x));
                    }
                }
                return returnList;
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }

        return null;
    }

    /*
     public IMap<Integer, ArrayList<Board>> boardMap() throws IllegalAccessException, SQLException, Throwable {
     HazelcastInstance hazelcastInstance = getInstance();
     Board board = new Board();
     boards = hazelcastInstance.getMap("boards");
     if (boards.isEmpty()) {
     boards.put(0, board.getAllBoards());
     }
     return boards;
     }
     */
    public void putToMap(Post post) {
        ArrayList<Post> tempList = posts.get(post.getMainBoardID());
        tempList.add(post);
        posts.put(post.getMainBoardID(), tempList);
    }

    public static void main(String[] args) throws InterruptedException, InstantiationException, 
            IllegalAccessException, IllegalAccessException, SQLException {
        HazelcastInstance hazelcastInstance = Hazelcast.newHazelcastInstance();
        IMap map = hazelcastInstance.getMap("test");
        Collection<DistributedObject> objects = hazelcastInstance.getDistributedObjects();
        for (DistributedObject distributedObject : objects) {
            if (distributedObject instanceof IMap) {
                System.out.println("There is a map with name: " + distributedObject.getName());
            }
        }
        
        PostCache postCache = new PostCache();
        ArrayList<Post> postsOfLeaves = new ArrayList<Post>();
        try {
            postsOfLeaves = postCache.getPostsOfThisBoard(17);
        } catch (InstantiationException | IllegalAccessException | SQLException ex) {
            System.out.println(ex);
        }
    }

}
