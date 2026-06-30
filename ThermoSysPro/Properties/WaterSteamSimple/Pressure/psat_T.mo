within ThermoSysPro.Properties.WaterSteamSimple.Pressure;

function psat_T "Saturation pressure for given temperature"
  input Units.SI.Temperature T "Temperature";
  output Units.SI.Pressure p "Pressure";
protected
  psat_T_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  p := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(coef, T);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end psat_T;