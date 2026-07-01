within ThermoSysPro.Properties.WaterSteamSimple.Utilities;

function polynomial_xy_order3_derivative2_yy
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_yy;
algorithm
  der2_polynomial_yy := coef.c02*2 + coef.c12*x*2 + coef.c03*6*y;
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end polynomial_xy_order3_derivative2_yy;