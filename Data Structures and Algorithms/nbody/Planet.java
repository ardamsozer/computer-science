public class Planet {
    double xxPos; //The planet’s current x position
    double yyPos; //The planet’s current y position
    double xxVel; //The planet’s current velocity in the x direction
    double yyVel; //The planet’s current velocity in the y direction
    double mass; //The planet’s mass
    String imgFileName; //The name of the file that corresponds to the image that depicts the planet (for example, jupiter.gif)

    public Planet(double xP, double yP, double xV, double yV, double m, String img) {
        this.xxPos = xP;
        this.yyPos = yP;
        this.xxVel = xV;
        this.yyVel = yV;
        this.mass = m;
        this.imgFileName = img;
    }

    public Planet(Planet p) {
        this.xxPos = p.xxPos;
        this.yyPos = p.yyPos;
        this.xxVel = p.xxVel;
        this.yyVel = p.yyVel;
        this.mass = p.mass;
        this.imgFileName = p.imgFileName;
    }

    public double calcDistance(Planet otherPlanet) {
        double dx = otherPlanet.xxPos - this.xxPos;
        double dy = otherPlanet.yyPos - this.yyPos;
        double r = Math.sqrt((dx * dx) + (dy * dy));
        return r;
    }

    public double calcForceExertedBy(Planet otherPlanet) {
        double r = this.calcDistance(otherPlanet);
        double rSqrd = Math.pow(r, 2);
        double G = 6.67 * Math.pow(10, -11);
        double F = (G * this.mass * otherPlanet.mass) / rSqrd;
        return F;
    }

    public double calcForceExertedByX(Planet otherPlanet) {
        double dx = otherPlanet.xxPos - this.xxPos;
        double F = this.calcForceExertedBy(otherPlanet);
        double r = this.calcDistance(otherPlanet);
        double Fx = (F * dx) / r;
        return Fx;
    }

    public double calcForceExertedByY(Planet otherPlanet) {
        double dy = otherPlanet.yyPos - this.yyPos;
        double F = this.calcForceExertedBy(otherPlanet);
        double r = this.calcDistance(otherPlanet);
        double Fy = (F * dy) / r;
        return Fy;
    }

    public double calcNetForceExertedByX(Planet[] otherPlanets) {
        double FxNet = 0.0;
        for (int i = 0; i < otherPlanets.length; i++) {
            Planet other = otherPlanets[i];
            if (this.equals(other)) {
                continue;
            }
            double Fx = this.calcForceExertedByX(other);
            FxNet += Fx;
        }
        return FxNet;
    }

    public double calcNetForceExertedByY(Planet[] otherPlanets) {
        double FyNet = 0.0;
        for (int i = 0; i < otherPlanets.length; i++) {
            Planet other = otherPlanets[i];
            if (this.equals(other)) {
                continue;
            }
            double Fy = this.calcForceExertedByY(other);
            FyNet += Fy;
        }
        return FyNet;
    }

    public void update(double dt, double fX, double fY) {
        double Vx = this.xxVel;
        double Vy = this.yyVel;
        double mass = this.mass;
        double pX = this.xxPos;
        double pY = this.yyPos;
        double aNetX = fX / mass;
        double aNetY = fY / mass;
        double VxNew = Vx + (dt * aNetX);
        double VyNew = Vy + (dt * aNetY);
        double pXNew = pX + (dt * VxNew);
        double pYNew = pY + (dt * VyNew);
        this.xxVel = VxNew;
        this.yyVel = VyNew;
        this.xxPos = pXNew;
        this.yyPos = pYNew;
    }

    public void draw() {
        double xpos = this.xxPos;
        double ypos = this.yyPos;
        String img = "images/" + this.imgFileName;
        StdDraw.picture(xpos, ypos, img);
        //StdDraw.show();
    }
}