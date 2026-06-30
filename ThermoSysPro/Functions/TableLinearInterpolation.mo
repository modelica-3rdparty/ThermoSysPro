within ThermoSysPro.Functions;

function TableLinearInterpolation "Table linear interpolation"
  input Real TabP[:] "1st reference table";
  input Real TabX[:] "2nd reference table";
  input Real TabY[:, :] "Results table";
  input Real P "1st reference value";
  input Real X "2nd reference value";
  output Real Y "Interpolated result";
protected
  Real deltaYX "Y step wrt. X";
  Real deltaYP "Y step wrt. P";
algorithm
  (Y, deltaYX, deltaYP) := ThermoSysPro.Functions.Utilities.TableLinearInterpolation_i(TabP, TabX, TabY, P, X);
  annotation(
    smoothOrder = 2,
    Icon(graphics),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    ", revisions = "
Author  

Baligh El Hefni   

    "));
end TableLinearInterpolation;