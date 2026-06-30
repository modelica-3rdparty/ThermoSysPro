within ThermoSysPro.Properties.WaterSteamSimple.Energy;

function u1_PT "Specific inner energy in liquid region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.SpecificEnergy u "Specific inner energy";
  u1_PT_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  u := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(coef, p, T);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end u1_PT;