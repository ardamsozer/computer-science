package gitlet;


import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Map;
import java.util.TreeMap;


public class Stage implements Serializable {

    private Map<String, String> stagingArea;

    private Map<String, String> trackedFiles;

    private HashSet<String> removedFiles;

    private ArrayList<String> branches;

    public Stage() {
        stagingArea = new TreeMap<>();
        trackedFiles = new TreeMap<>();
        removedFiles = new HashSet<>();
        branches = new ArrayList<>();
    }


    public void serializeStage() {
        File stage = new File(".gitlet/StagingArea/" + "stage.ser");
        Utils.writeContents(stage, Utils.serialize(this));

    }

    public static Stage deserializeStage() {
        File stage = new File(".gitlet/StagingArea/" + "stage.ser");
        byte[] fileBytes = Utils.readContents(stage);
        return (Stage) Utils.deserialize(fileBytes);
    }

    public Map<String, String> getStagingArea() {
        return stagingArea;
    }

    public Map<String, String> getTrackedFiles() {
        return trackedFiles;
    }

    public HashSet<String> getRemovedFiles() {
        return removedFiles;
    }

    public ArrayList<String> getBranches() {
        return branches;
    }

    public void updateTrackedFiles(Map<String, String> updateMap) {
        trackedFiles = new TreeMap<>(updateMap);
    }
}



