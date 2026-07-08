within ThermoSysPro.Properties.SolarSalt;

function Enthalpy_T
  input Units.SI.Temperature temp "Fluid temperature (K)";
  output Units.SI.SpecificEnthalpy h "Enthalpy (J/kg)";
protected
  constant Real Enthalpy_c0 = -798297.6386;
  constant Real Enthalpy_c1 = 1396.0182;
  constant Real Enthalpy_c2 = 0.086;
algorithm
  h := Enthalpy_c0 + Enthalpy_c1*temp + Enthalpy_c2*temp^2;
  annotation(
    derivative = Enthalpy_derT,
    inverse(temp = Temperature_h(h)),
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end Enthalpy_T;