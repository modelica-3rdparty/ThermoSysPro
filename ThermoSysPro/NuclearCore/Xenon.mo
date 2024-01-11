within ThermoSysPro.NuclearCore;
model Xenon "xenon as fission product"
  parameter Boolean steady_state = true "Steady-state (true) or fixed values (false) initialization";
  parameter Real Xe_start = 0 "Initial concentration of Xenon (if steady_state=false)" annotation (Dialog(enable=not steady_state));
  parameter Real I_start = 0 "Initial concentration of Iode (if steady_state=false)" annotation (Dialog(enable=not steady_state));
  parameter ThermoSysPro.Units.SI.Power NominalThPower = 2768e6 "Nominal Thermal Power";
  parameter ThermoSysPro.Units.SI.Mass FuelMass = 72376 "Nuclear Fuel Mass";
  parameter Real Enrichment = 0.02433 "Fuel enrichement";
  constant ThermoSysPro.Units.SI.Energy FissionEnergy = 3.09e-11 "Power from each fission";
  constant Real FastFissionFactor = 1.07 "Fast Fission Factor";
  constant ThermoSysPro.Units.SI.Area microCrossSection = 5.795e-26 "Fuel microscopic fission cross-section";
  constant Real AtomicMass = 235.04393 "Fuel atomic mass";
  ThermoSysPro.Units.SI.Frequency FissionRate "Reactor Fission Rate";
  ThermoSysPro.Units.SI.Frequency ThFissionRate "Thermal Fission Rate";
  ThermoSysPro.Units.SI.Mass FissilMass "Mass of fissil fuel";
  Real U_235 "Number of 235Uranium nuclei";
  constant Real I_yield = 0.064 "Total fission yield of 135Iode";
  constant Real Xe_yield = 0.0025 "Total fission yield of 135Xenon";
  constant ThermoSysPro.Units.SI.Frequency I_decay = 2.874e-5 "Decay constant of 135Iode";
  constant ThermoSysPro.Units.SI.Frequency Xe_decay = 2.027e-5 "Decay constant of 135Xenon";
  constant ThermoSysPro.Units.SI.Area Xe_abs_CS = 2.75e-22 "Microscopic absorption cross-section of 135Xenon";
  ThermoSysPro.Units.SI.Power power "Thermal Nuclear Power";
  Real I_135 "Number of 135Iode nuclei";
  Real Xe_135 "Number of 135Xenon nuclei";
  ThermoSysPro.Units.SI.NeutronFluenceRate NeutronFlux "Neutron Flux";
  ThermoSysPro.Units.SI.Frequency FissionProduction "";
  ThermoSysPro.Units.SI.Frequency DecayProduction "";
  ThermoSysPro.Units.SI.Frequency DecayRemoval "";
  ThermoSysPro.Units.SI.Frequency AbsorptionRemoval "";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wrel
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Xe
    annotation (Placement(transformation(extent={{72,-52},{92,-32}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal I
    annotation (Placement(transformation(extent={{72,30},{92,50}})));
initial equation
  if steady_state then
    der(I_135) = 0;
    der(Xe_135) = 0;
  else
    I_135 = I_start;
    Xe_135 = Xe_start;
  end if;
equation
  Xe.signal = Xe_135;
  I.signal = I_135;
  power = FissionEnergy*FissionRate;
  ThFissionRate = FissionRate/FastFissionFactor;
  ThFissionRate = NeutronFlux * microCrossSection * U_235;
  FissilMass = FuelMass * Enrichment;
  U_235 = FissilMass * 1000 / AtomicMass * Modelica.Constants.N_A;
  power = Wrel.signal * NominalThPower;
  der(I_135) = ThFissionRate*I_yield - I_135*I_decay;
  der(Xe_135) = ThFissionRate*Xe_yield + I_135*I_decay - Xe_135*Xe_decay - NeutronFlux*Xe_135*Xe_abs_CS;
  FissionProduction = power/FissionEnergy*Xe_yield;
  DecayProduction = I_135*I_decay;
  DecayRemoval = Xe_135*Xe_decay;
  AbsorptionRemoval = NeutronFlux*Xe_135*Xe_abs_CS;
  annotation (                                   Icon(graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={28,108,200},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,66},{60,-56}},
          lineColor={0,140,72},
          textString="Xe",
          textStyle={TextStyle.Bold})}));
end Xenon;
