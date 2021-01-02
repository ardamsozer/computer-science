package gitlet;
/**
 * Driver class for Gitlet, the tiny stupid version-control system.
 * Group: Ahmad Jawaid, Arda Mark Sozer, Daniel Huang, Mohamed El Sewedy
 */
public class Main {

    /* Usage: java gitlet.Main ARGS, where ARGS contains
       <COMMAND> <OPERAND> .... */
    public static void main(String... args) {
        Commands command = new Commands();
        command.doMethod(args);
        System.exit(0);
        //later need to delete the entire try catch block and replace with above.
        /*try {
            command.doMethod(args);
        } catch (Exception e) {
            System.out.println("Uh Oh! There was an error");
            e.printStackTrace();
            System.exit(0);
        }*/
    }
}
