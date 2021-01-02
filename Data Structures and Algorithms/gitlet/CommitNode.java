package gitlet;


import java.io.File;
import java.io.Serializable;
import java.util.Map;
import java.util.TreeMap;
import java.util.Date;

public class CommitNode implements Serializable {
    private String message;
    private Date time;
    TreeMap<String, String> blobs;
    private String hashOfParent;

    public CommitNode(String m, Date t) {
        this.message = m;
        this.time = t;
        this.blobs = commitStagingArea();
        this.hashOfParent = this.hashOfParent();

    }

    private TreeMap<String, String> commitStagingArea() {

        Stage stage = Stage.deserializeStage();

        for (String filename : stage.getRemovedFiles()) {
            stage.getTrackedFiles().remove(filename);
        }

        for (Map.Entry<String, String> entry : stage.getTrackedFiles().entrySet()) {
            if (!stage.getStagingArea().containsKey(entry.getKey())) {
                stage.getStagingArea().put(entry.getKey(), entry.getValue());
            }
        }

        TreeMap<String, String> commitFiles = new TreeMap<>(stage.getStagingArea());
        stage.updateTrackedFiles(new TreeMap<String, String>(stage.getStagingArea()));
        //stage.TrackedFiles = new TreeMap<>(stage.getStagingArea());

        stage.getStagingArea().clear();
        stage.getRemovedFiles().clear();

        stage.serializeStage();

        return commitFiles;
    }

    private String hashOfParent() {
        if (message.equals("initial commit")) {
            return null;
        } else {
            return Head.getHashOfHead();
        }

    }

    /* Returns the message of the CommitNode */
    public String getMessage() {
        return message;
    }

    /* Returns the hash of the parent*/
    public String getHashOfParent() {
        return hashOfParent;
    }

    /* Returns the date */
    public Date getTime() {
        return time;
    }

    /**Takes in the latest commit node, serializes it ans returns hash */

    public String serializeNewCommit() {
        byte[] bytes = Utils.serialize(this);
        String hashOfCommit = Utils.sha1(bytes);
        File commitFile = new File(".gitlet/CommitNodes/" + hashOfCommit);
        Utils.writeContents(commitFile, bytes);
        return hashOfCommit;
    }

    public CommitNode getParentNode() {
        File commitFile = new File(".gitlet/CommitNodes/" + this.hashOfParent);
        byte[] fileBytes = Utils.readContents(commitFile);
        return (CommitNode) Utils.deserialize(fileBytes);
    }

    public static CommitNode getCommitNode(String hashOfNode) {
        int lengthOfHashCode = hashOfNode.length();
        for (String hashCode : Utils.plainFilenamesIn(".gitlet/CommitNodes/")) {
            if (hashOfNode.equals(hashCode.substring(0, lengthOfHashCode))) {
                hashOfNode = hashCode;
                File commitFile = new File(".gitlet/CommitNodes/" + hashOfNode);
                byte[] fileBytes = Utils.readContents(commitFile);
                return (CommitNode) Utils.deserialize(fileBytes);
            }
        }
        return null;
    }
}
