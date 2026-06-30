within ThermoSysPro.Properties.SolarSalt;

function Temperature_derk "derivative of Temperature_k"
  input Units.SI.ThermalConductivity k "Thermal Conductivity (W/mK)";
  input Real der_k "thermal conductivity time derivative (W/mKs)";
  output Real der_temp "fluid temperature time derivative";
protected
  constant Real tempC1 = 5263.16;
algorithm
  der_temp := tempC1*der_k;
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Temperature_derk;