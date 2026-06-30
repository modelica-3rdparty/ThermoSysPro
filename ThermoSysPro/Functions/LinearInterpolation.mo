within ThermoSysPro.Functions;

function LinearInterpolation "Linear interpolation"
  input Real TabX[:] "References table";
  input Real TabY[:] "Results table";
  input Real X "Reference value";
  output Real Y "Interpolated result";
protected
  Real deltaYX "Step in Y w.r.t. X";
algorithm
  (Y, deltaYX) := ThermoSysPro.Functions.Utilities.LinearInterpolation_i(TabX, TabY, X);
  annotation(
    smoothOrder = 1,
    Icon(graphics),
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  

    ", revisions = "
    "));
end LinearInterpolation;