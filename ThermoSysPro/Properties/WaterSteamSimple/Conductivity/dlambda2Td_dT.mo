within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;

function dlambda2Td_dT "Derivative of conductivity wrt. specific enthalpy at constant pressure in vapor region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Real dlambdaTd "Derivative of conductivity wrt.  temperature at constant density";
protected
  lambda2_dT_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  dlambdaTd := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(coef, d, T);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end dlambda2Td_dT;