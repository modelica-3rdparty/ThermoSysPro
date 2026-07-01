within ThermoSysPro.Functions;

function SmoothAbs "Smooth abs function"
  input Real x;
  input Real alpha = 100;
  output Real y;
algorithm
  y := SmoothSign(x, alpha)*x;
  annotation(
    smoothOrder = 2,
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
    "));
end SmoothAbs;