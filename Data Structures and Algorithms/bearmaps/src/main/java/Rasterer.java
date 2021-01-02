import com.google.gson.internal.bind.MapTypeAdapterFactory;

import java.awt.image.Raster;
import java.util.LinkedList;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

/**
 * This class provides all code necessary to take a query box and produce
 * a query result. The getMapRaster method must return a Map containing all
 * seven of the required fields, otherwise the front end code will probably
 * not draw the output correctly.
 */
public class Rasterer {
    /** The max image depth level. */
    public static final int MAX_DEPTH = 7;
    public static final double Root_lonDPP = MapServer.ROOT_LONDPP;

    //LonDPPs Array:  index = depth or zoom level. value at that index = lonDPP of that zoom level
    public static final double[] lonDPPs = {Root_lonDPP, Root_lonDPP / 2, Root_lonDPP / 4, Root_lonDPP / 8,
            Root_lonDPP/ 16, Root_lonDPP / 32, Root_lonDPP / 64, Root_lonDPP / 128};

    /**
     * Takes a user query and finds the grid of images that best matches the query. These images
     * will be combined into one big image (rastered) by the front end. The grid of images must obey
     * the following properties, where image in the grid is referred to as a "tile".
     * <ul>
     *     <li>The tiles collected must cover the most longitudinal distance per pixel (LonDPP)
     *     possible, while still covering less than or equal to the amount of longitudinal distance
     *     per pixel in the query box for the user viewport size.</li>
     *     <li>Contains all tiles that intersect the query bounding box that fulfill the above
     *     condition.</li>
     *     <li>The tiles must be arranged in-order to reconstruct the full image.</li>
     * </ul>
     * @param params The RasterRequestParams containing coordinates of the query box and the browser
     *               viewport width and height.
     * @return A valid RasterResultParams containing the computed results.
     *
     * */
    public RasterResultParams getMapRaster(RasterRequestParams params) {
        /* TODO: Make sure you can explain every part of the task before you begin.
         * Hint: Define additional classes to make it easier to pass around multiple values, and
         * define additional methods to make it easier to test and reason about code. */

        //We must first instantiate a RasterResultParams.Builder object then fill its field with the .set...() methods
        //Then we .create() it which turns it into a RasterResultParams object, which we then  return
        RasterResultParams.Builder toReturn = new RasterResultParams.Builder();

        //Following are the QUERY BOX parameters:
        double ullatQuerry = params.ullat;
        double ullonQuerry = params.ullon;
        double lrlatQuerry = params.lrlat;
        double lrlonQuerry = params.lrlon;
        double widthQuerry = params.w;
        double heightQuerry = params.h;

        //case: if the query box is completely outside of Berkeley
        if (lrlonQuerry < MapServer.ROOT_ULLON || ullonQuerry > MapServer.ROOT_LRLON
                || lrlatQuerry > MapServer.ROOT_ULLAT || ullatQuerry < MapServer.ROOT_LRLAT) {
            return RasterResultParams.queryFailed();
        }

        if (ullonQuerry > lrlonQuerry || ullatQuerry < lrlatQuerry) {
            return RasterResultParams.queryFailed();
        }


        //the Query's specified lonDPP:
        double lonDPPofQueryBox = lonDPP(lrlonQuerry, ullonQuerry, widthQuerry);
        //Our goal is to find the tiles with the greatest lonDPP that is still
        // less than the lonDPP requested by the query box

        //user desired zoom level:
        int depth = getAppopriateDepth(lonDPPofQueryBox); //Sting with depth level (Ex: "d3")

        //Now that we know what level of depth to use, we now have to figure out which pictures we need
        LinkedList<Integer>[] xygrid = createXYgrid(depth, ullonQuerry, lrlonQuerry, ullatQuerry, lrlatQuerry);

        int rows = xygrid[1].size();
        int cols = xygrid[0].size();

        String[][] grid = new String[rows][cols];

        for (int i = 0; i < rows; i += 1) {
            for (int j = 0; j < cols; j += 1) {
                grid[i][j] = "d" + depth + "_x" + xygrid[0].get(j) + "_y" + xygrid[1].get(i) + ".png";
            }
        }

        double xIncrement = getdx(depth);
        double yIncrement = getdy(depth);

        toReturn.setRasterUlLon(MapServer.ROOT_ULLON + (xIncrement * xygrid[0].getFirst()));
        toReturn.setRasterLrLon(MapServer.ROOT_ULLON + (xIncrement * (xygrid[0].getLast()+ 1))); // IFFY PART

        toReturn.setRasterUlLat(MapServer.ROOT_ULLAT - (yIncrement * xygrid[1].getFirst()));
        toReturn.setRasterLrLat(MapServer.ROOT_ULLAT - (yIncrement * (xygrid[1].getLast() + 1))); // IFFY PART

        toReturn.setRenderGrid(grid);
        toReturn.setQuerySuccess(true);
        toReturn.setDepth(depth);
        return toReturn.create();
    }

    /**
     * Calculates the lonDPP of an image or query box
     * @param lrlon Lower right longitudinal value of the image or query box
     * @param ullon Upper left longitudinal value of the image or query box
     * @param width Width of the query box or image
     * @return lonDPP
     */
    private double lonDPP(double lrlon, double ullon, double width) {
        return (lrlon - ullon) / width;
    }

    public int getAppopriateDepth(Double lonDPPofQuerybox) { // SHIFTED ALL ABOVE BY ONE
        if (lonDPPofQuerybox > lonDPPs[0]) {
            return 0;
        } else if (lonDPPofQuerybox > lonDPPs[1]) {
            return 1;
        } else if (lonDPPofQuerybox > lonDPPs[2]) {
            return 2;
        } else if (lonDPPofQuerybox > lonDPPs[3]) {
            return 3;
        } else if (lonDPPofQuerybox > lonDPPs[4]) {
            return 4;
        } else if (lonDPPofQuerybox > lonDPPs[5]) {
            return 5;
        } else if (lonDPPofQuerybox > lonDPPs[6]) {
            return 6;
        } else { //lonDPP of Query is smaller than d7
            return 7;
        }
    }

    public LinkedList<Integer>[] createXYgrid(int depth, double queryullon, double querylrlon,
                                double queryullat, double querylrlat) {

        LinkedList<Integer> xIndeces = new LinkedList<>();
        LinkedList<Integer> yIndeces = new LinkedList<>();


        double dx = getdx(depth);
        double dy = getdy(depth);


        int xindex = 0;
        int yindex = 0;

        double startingxpos = MapServer.ROOT_ULLON;
        double endingxpos = MapServer.ROOT_LRLON;
        while (startingxpos < endingxpos) {
            if (startingxpos + dx > queryullon && startingxpos < querylrlon) { // LOGIC
                xIndeces.add(xindex);
                xindex += 1;
                startingxpos += dx;
            } else {
                xindex += 1;
                startingxpos += dx;
            }
        }

        double startingypos = MapServer.ROOT_ULLAT;
        double endingypos = MapServer.ROOT_LRLAT;
        while (startingypos > endingypos) {
            if (startingypos - dy < queryullat && startingypos > querylrlat) { // LOGIC
                yIndeces.add(yindex);
                yindex += 1;
                startingypos -= dy;
            } else {
                yindex += 1;
                startingypos -= dy;
            }
        }

        // Instantiates a LinkedList array with
        // 0th position be x-values
        // 1th position be y-values
        LinkedList<Integer>[] toReturn = new LinkedList[2];

        toReturn[0] = new LinkedList<>();
        toReturn[1] = new LinkedList<>();

        toReturn[0].addAll(xIndeces);
        toReturn[1].addAll(yIndeces);

        return toReturn;
    }

    public double getdx(int depth) {
        double dx_d0 = MapServer.ROOT_LRLON - MapServer.ROOT_ULLON;
        if (depth == 0) { // LOGIC
            return dx_d0;
        }
        return dx_d0 / Math.pow(2, depth);
    }

    public double getdy(int depth) {
        double dy_d0 = MapServer.ROOT_ULLAT - MapServer.ROOT_LRLAT;
        if (depth == 0) { // LOGIC
            return dy_d0;
        }
        return dy_d0 / Math.pow(2, depth);
    }
}
