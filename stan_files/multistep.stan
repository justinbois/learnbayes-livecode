
functions {
  real sign(int j, int m) {
    /* Sign of respective term in sum of PDF. If both m and j are
     * even or both are odd, then sign is positive. Otherwise, sign
     * is negative.
     */
    if ((m % 2) + (j % 2) == 1) return -1.0;

    return 1.0;
  }
  

  real signed_log_sum_exp(vector terms, row_vector signs) {
    // log-sum-exp trick with signed arguments.
    real max_term = max(terms);
    vector[size(terms)] adjusted_terms = terms - max_term;      

    return max_term + log(signs * exp(adjusted_terms));
  }
  

  real catastrophe_lpdf(real t, vector tau, row_vector signs, int m) {
    real log_pdf;
    real log_prod;
    vector[m] terms;
    
    // For case where m = 1, it's just Exponential
    if (m == 1) {
      log_pdf = exponential_lpdf(t | 1.0 / tau[1]);
    }

    // For all other cases, first compute summed terms of PDF    
    else {
      for (j in 1:m) {
        log_prod = 0.0;
        for (k in 1:m) {
          if (j != k) {
            log_prod += log(abs(tau[j] - tau[k]));
          }
        }
        terms[j] = (m - 2) * log(tau[j]) - t / tau[j] - log_prod;
      }
      
      // Compute log PDF using logsumexp trick 
      log_pdf = signed_log_sum_exp(terms, signs);
    }
    
    return log_pdf;
  }
}


data {
  int m;
  int N;
  array[N] real t;
}


transformed data {
  row_vector[m] signs;

  for (j in 1:m) {
    signs[j] = sign(j, m);
  }
}


parameters {
  ordered[m] log_tau;
}


transformed parameters {
  vector[m] tau = 10 ^ log_tau;
}

model {
  log_tau ~ normal(0.5, 0.75);
  
  for (i in 1:N) {
    target += catastrophe_lpdf(t[i] | tau, signs, m);
  }
}


generated quantities {
  array[N] real log_lik;
  array[N] real t_ppc;
  
  for (i in 1:N) {
    log_lik[i] = catastrophe_lpdf(t[i] | tau, signs, m);
    t_ppc[i] = exponential_rng(1.0 / tau[1]);

    for (j in 2:m) {
      t_ppc[i] += exponential_rng(1.0 / tau[j]);
    }
  }
}
