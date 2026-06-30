within ThermoSysPro.Properties.WaterSteamSimple.Density;

function d1sat_T "density at liquid saturation for given temperature"
  input Units.SI.Temperature T "Temperature";
  output Units.SI.Density d "density";
protected
  d1sat_T_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5(coef, T);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end d1sat_T;