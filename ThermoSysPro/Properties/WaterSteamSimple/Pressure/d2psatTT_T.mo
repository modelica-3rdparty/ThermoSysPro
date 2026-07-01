within ThermoSysPro.Properties.WaterSteamSimple.Pressure;

function d2psatTT_T "Second derivative of saturation pressure wrt. temperature"
  input Units.SI.Temperature T "Temperature";
  output Real d2pTT "Second derivative of pressure";
protected
  psat_T_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  d2pTT := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative2(coef, T);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end d2psatTT_T;