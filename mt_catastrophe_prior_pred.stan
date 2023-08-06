data {
  int m;
  int N;
}


generated quantities {
  array[m] real tau;
  array[N] real t;
  
  for (i in 1:m) {
    tau[i] = 10 ^ normal_rng(0.5, 0.75);
  }
  
  for (i in 1:N) {
    t[i] = exponential_rng(1.0 / tau[1]);
    for (j in 2:m) {
      t[i] += exponential_rng(1.0 / tau[j]);
    }
  }
}