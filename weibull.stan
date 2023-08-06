
data {
  int N;
  array[N] real t;
}


parameters {
  real<lower=0> alpha;
  real log_sigma;
}


transformed parameters {
  real<lower=0> sigma = 10 ^ log_sigma;
}


model {
  alpha ~ normal(1.5, 1.0);
  log_sigma ~ normal(0.5, 0.75);
  
  t ~ weibull(alpha, sigma);
}


generated quantities {
  array[N] real t_ppc;

  for (i in 1:N) {
    t_ppc[i] = weibull_rng(alpha, sigma);
  }
}
