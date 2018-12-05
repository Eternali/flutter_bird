// Credits to: https://github.com/Slemgrim/noise_algorithms

class Grad {

  Grad(this.x, this.y, this.z);

  double x, y, z;

  double dot2(double x, double y) {
    return this.x * x + this.y * y;
  }

  double dot3(double x, double y, double z) {
    return this.x * x + this.y * y + this.z * z;
  }

}
