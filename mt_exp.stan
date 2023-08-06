data {
  int N;
  array[N] real t;
}


parameters {
  // Log of tau in units of minutes
  real log_tau;
}



transformed parameters {
  real<lower=0> tau = 10 ^ log_tau;
  real<lower=0> beta_ = 1.0 / tau;
}


model {
  log_tau ~ normal(0.5, 0.75);
  
  t ~ exponential(beta_);
}


generated quantities {
  array[N] real t_ppc;

  for (i in 1:N) {
    t_ppc[i] = exponential_rng(beta_);
  }
}