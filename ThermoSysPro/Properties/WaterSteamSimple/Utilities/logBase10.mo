within ThermoSysPro.Properties.WaterSteamSimple.Utilities;

function logBase10
  input Real x;
  output Real y;
algorithm
//y:= log10(x);
  y := log10(abs(x) + 1e-10);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end logBase10;