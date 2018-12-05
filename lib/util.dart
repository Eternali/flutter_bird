
remap(double value, double from1, double from2, double to1, double to2) {
  // return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
  return to1 + (value - from1) * (to2 - to1) / (from2 - from1);
}
