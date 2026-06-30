within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;

function lambda2_Ph "Conductivity in vapor region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Units.SI.ThermalConductivity lambda "Thermal conductivity";
protected
  lambda2_Ph_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  lambda := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(coef, p, h);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end lambda2_Ph;