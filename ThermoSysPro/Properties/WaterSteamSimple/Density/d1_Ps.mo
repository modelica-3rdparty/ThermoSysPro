within ThermoSysPro.Properties.WaterSteamSimple.Density;

function d1_Ps "Density in liquid region for given pressure and specific entropy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEntropy s "Specific entropy";
  output Units.SI.Density d "Density";
protected
  d1_Ps_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(coef, p, s);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end d1_Ps;