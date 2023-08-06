
data {
  int N;
  array[N] real t;
}


parameters {
  real<lower=1> alpha;
  real log_tau;
}


transformed parameters {
  real<lower=0> tau = 10 ^ log_tau;
  real<lower=0> beta_ = 1.0 / tau;
}


model {
  alpha ~ normal(1, 50);
  log_tau ~ normal(0.5, 0.75);
  
  t ~ gamma(alpha, beta_);
}


generated quantities {
  array[N] real t_ppc;

  for (i in 1:N) {
    t_ppc[i] = gamma_rng(alpha, beta_);
  }
}
