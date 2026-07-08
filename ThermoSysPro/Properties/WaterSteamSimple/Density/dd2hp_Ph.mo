within ThermoSysPro.Properties.WaterSteamSimple.Density;

function dd2hp_Ph "Derivative of density wrt. specific enthalpy at constant pressure in steam region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Units.SI.DerDensityByEnthalpy ddhp "Derivative of density wrt. specific enthalpy at constant pressure";
protected
  d2_Ph_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  ddhp := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(coef, p, h);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end dd2hp_Ph;