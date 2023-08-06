functions {
  real twostep_lpdf(array[] real ys, vector tau) {
    // log of the PDF for the two-successive Poisson process model
    real log_pdf;

    // Special case where taus are very close
    if (tau[2] - tau[1] < 1e-8) {
      log_pdf = gamma_lpdf(ys | 2, 1.0 / tau[1]);
    }
    else {
      log_pdf = -num_elements(ys) * log(tau[2] - tau[1]);
      for (y in ys) {
        log_pdf += log_diff_exp(-y / tau[2], -y / tau[1]);
      }
    }
    
    return log_pdf;
  }
}


data {
  int N;
  array[N] real t;
}


parameters {
  ordered[2] log_tau;
}


transformed parameters {
  vector[2] tau = 10 ^ log_tau;
}


model {
  log_tau ~ normal(0.5, 0.75);

  t ~ twostep(tau);
}


generated quantities {
  array[N] real t_ppc;

  for (i in 1:N) {
    t_ppc[i] = exponential_rng(1.0 / tau[1]) + exponential_rng(1.0 / tau[2]);
  }
}