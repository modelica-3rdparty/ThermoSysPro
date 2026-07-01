within ThermoSysPro.Properties.DryAirIdealGas;

function IsobaricExpansionCoefficient_T "Isobaric Expansion Coefficient computation for Dry Air Ideal Gas (input T)"
  input Units.SI.Temperature T "Temperature (K)";
  output Units.SI.CubicExpansionCoefficient Beta "Isobaric Expansion Coefficient (1/K)";
algorithm
  Beta := 1/T;
  annotation(
    derivative = derIsobaricExpansionCoefficient_derT,
    Documentation(info = "## Copyright © EDF 2002 - 2025

## ThermoSysPro Version 4.2

    "));
end IsobaricExpansionCoefficient_T;