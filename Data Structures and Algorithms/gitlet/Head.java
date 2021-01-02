package gitlet;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class Head {

    public static String getHashOfHead() {
        try {
            String branch = getActiveBranch();
            File headFile = new File(".gitlet/Heads/" + branch + "/head.txt");
            Scanner sc2 = new Scanner(headFile);
            return sc2.nextLine();
        } catch (IOException e) {
            return "";
        }
    }

    public static CommitNode getHeadNode() {
        File commitFile = new File(".gitlet/CommitNodes/" + getHashOfHead());
        byte[] fileBytes = Utils.readContents(commitFile);
        return (CommitNode) Utils.deserialize(fileBytes);
    }

    public static void updateHead(String shaCode) {

        try {
            String branch = getActiveBranch();

            File headFile = new File(".gitlet/Heads/" + branch + "/head.txt");
            FileWriter writer = new FileWriter(headFile);
            writer.write(shaCode);
            writer.close();
        } catch (IOException e) {
            System.out.print("IOException in updateHead");
        }

    }

    public static void updateActiveBranch(String branch) {
        try {
            File activeBranch = new File(".gitlet/Heads/ActiveBranch.txt");
            FileWriter writer = new FileWriter(activeBranch);
            writer.write(branch);
            writer.close();
        } catch (IOException e) {
            System.out.print("IOException in updateActiveBranch");
        }

    }
    public static String getActiveBranch() {
        try {
            File activeBranch = new File(".gitlet/Heads/ActiveBranch.txt");
            Scanner sc1 = new Scanner(activeBranch);
            return sc1.nextLine();
        } catch (IOException e) {
            System.out.print("IOException in getActiveBranch");
            return "";
        }
    }

    public static CommitNode getBranchHead(String branch) {
        try {
            File headFile = new File(".gitlet/Heads/" + branch + "/head.txt");
            Scanner sc2 = new Scanner(headFile);
            String hashOfHead =  sc2.nextLine();

            File commitFile = new File(".gitlet/CommitNodes/" + hashOfHead);
            byte[] fileBytes = Utils.readContents(commitFile);
            return (CommitNode) Utils.deserialize(fileBytes);


        } catch (IOException e) {
            return null;
        }
    }

    public static String getHashOfBranchHead(String branch) {
        try {
            File headFile = new File(".gitlet/Heads/" + branch + "/head.txt");
            Scanner sc2 = new Scanner(headFile);
            return sc2.nextLine();
        } catch (IOException e) {
            return "";
        }
    }
}
