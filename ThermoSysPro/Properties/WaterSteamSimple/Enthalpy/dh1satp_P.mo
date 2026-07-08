within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;

function dh1satp_P "derivative of specific enthalpy at liquid saturation wrt. pressure"
  input Units.SI.Pressure p "pressure";
  output Real dhp(unit = "m3/kg") "derivative of enthalpy";
protected
  h1sat_P_coef coef annotation(
    Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
algorithm
  dhp := coef.a*coef.b*abs(p)^(coef.b - 1);
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end dh1satp_P;