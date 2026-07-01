within ThermoSysPro.Properties.FlueGases;

function FlueGases_Absorb "Flue gases - particles emissivity"
  extends ThermoSysPro.Properties.FlueGases.unsafeForJacobian;
  input Units.SI.AbsolutePressure PC "CO2 partial pressure";
  input Units.SI.AbsolutePressure PW "H2O partial pressure";
  input Real FV "Volume concentration of the particles in the flue gases";
  input Units.SI.Length L "Optical path";
  input Units.SI.Temperature T "Temperature";
  output Real EG " ";
  output Real ES " ";
  output Real emigaz "Flue gases - particles emissivity";
algorithm
  (EG, ES, emigaz) := ThermoSysPro.Properties.FlueGases.Absorb(PC*1e-5, PW*1e-5, FV, L, T);
  annotation(
    smoothOrder = 2,
    Icon(graphics),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

    "));
end FlueGases_Absorb;