public class NBody {

    public static double readRadius(String textFile) {
        if (textFile == null) {
            System.out.println("Please supply a country as a command line argument.");
            return 0.0;
        } else {
            /* Start reading in textFile */
            In in = new In(textFile);

            int numberOfPlanets = in.readInt();
            double radius = in.readDouble();
            return radius;
        }
    }

    public static Planet[] readPlanets(String textFile) {
        In in = new In(textFile);
        int rows = in.readInt();
        double radius = in.readDouble();
        Planet[] planetsArray = new Planet[rows];
        for (int i = 0; i < rows; i++) {
            double xCordinate = in.readDouble();
            double yCordinate = in.readDouble();
            double xVelocity = in.readDouble();
            double yVelocity = in.readDouble();
            double mass = in.readDouble();
            String pic = in.readString();
            Planet newPlanet = new Planet(xCordinate, yCordinate, xVelocity, yVelocity, mass, pic);
            planetsArray[i] = newPlanet;
        }
        return planetsArray;
    }

    public static void main(String args[]) {
        double T = Double.parseDouble(args[0]);
        double dt = Double.parseDouble(args[1]);
        String filename = args[2];
        double radius = readRadius(filename);
        Planet[] planets = readPlanets(filename);

        StdDraw.setScale(-radius, radius);
        StdDraw.clear();
        StdDraw.picture(0, 0, "images/starfield.jpg");
        StdDraw.show();

        for (int i = 0; i < planets.length; i++) {
            Planet planet = planets[i];
            planet.draw();
        }

        StdDraw.enableDoubleBuffering();

        double time = 0.0;

        while(time < T) {

            double[] xForces = new double[planets.length];
            double[] yForces = new double[planets.length];

            for (int i = 0; i < planets.length; i++) {
                Planet planet = planets[i];
                xForces[i] = planet.calcNetForceExertedByX(planets);
                yForces[i] = planet.calcNetForceExertedByY(planets);
                planet.update(dt, xForces[i], yForces[i]);
            }

            StdDraw.setScale(-radius, radius);
            StdDraw.clear();
            StdDraw.picture(0, 0, "images/starfield.jpg");
            StdDraw.show();

            for (int j = 0; j < planets.length; j++) {
                Planet planet2 = planets[j];
                planet2.draw();
            }

            StdDraw.show();
            StdDraw.pause(10);

            time += dt;
        }

        StdOut.printf("%d\n", planets.length);
        StdOut.printf("%.2e\n", radius);
        for (int i = 0; i < planets.length; i += 1) {
            StdOut.printf("%11.4e %11.4e %11.4e %11.4e %11.4e %12s\n",
                    planets[i].xxPos, planets[i].yyPos, planets[i].xxVel,
                    planets[i].yyVel, planets[i].mass, planets[i].imgFileName);
        }
    }
}
