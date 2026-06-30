within ThermoSysPro.Functions;

function SmoothSign "Smooth sign function"
  input Real x;
  input Real alpha = 100;
  output Real y;
algorithm
  y := SmoothStep(x, alpha) - SmoothStep(-x, alpha);
  annotation(
    smoothOrder = 2,
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
    "));
end SmoothSign;