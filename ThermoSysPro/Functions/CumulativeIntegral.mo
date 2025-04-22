within ThermoSysPro.Functions;
function CumulativeIntegral "Cumulative integral of an array"
  input Integer n "arrays size";
  input Real x[n] "x";
  input Real v[n] "array variable to integrate";

  output Real cumInt[n] "array of cumulative integrals";

protected
  Real integrals[n-1];

algorithm

  integrals := {sum(v[i:i+1])*(x[i+1]-x[i])/2  for i in 1:n-1};
  cumInt := cat(1, {0}, {sum(integrals[1:i]) for i in 1:n-1});

end CumulativeIntegral;
