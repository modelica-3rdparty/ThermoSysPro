within ThermoSysPro.Properties.SolarSalt;

function Density_derT
  input Units.SI.Temperature temp "Fluid temperature (K)";
  input Real der_temp "Fluid temperature time derivative (K/s)";
  output Real der_rho "Density time derivative (kg/(m3*s))";
protected
  constant Real Density_c1 = -0.636;
algorithm
  der_rho := Density_c1*der_temp;
  annotation(
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Density_derT;