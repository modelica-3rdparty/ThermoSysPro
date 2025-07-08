within ThermoSysPro.NuclearCore;
model Xenon "xenon as fission product"
  parameter Boolean steady_state = true "Steady-state (true) or fixed values (false) initialization" annotation(Dialog(group="Initialization"));
  parameter Real Xe_start = 0 "Initial concentration of Xenon (if steady_state=false)" annotation (Dialog(group="Initialization",enable=not steady_state));
  parameter Real I_start = 0 "Initial concentration of Iode (if steady_state=false)" annotation (Dialog(group="Initialization",enable=not steady_state));
  parameter ThermoSysPro.Units.SI.Density FuelDensity = 10950 "Fuel Density" annotation(Dialog(group="Fuel Properties"));
  parameter Real Enrichment = 0.02433 "Fuel enrichement" annotation(Dialog(group="Fuel Properties"));

  parameter ThermoSysPro.Units.SI.Radius Rp=0.004095 "Radius of the fuel pellet" annotation(Dialog(group="Fuel Volume"));
  parameter ThermoSysPro.Units.SI.Length Length=4.270 "Active lenght of the fuel rods" annotation(Dialog(group="Fuel Volume"));
  parameter Integer Rods_per_FA=264 "Number of fuel Rods per Fuel Assembly" annotation(Dialog(group="Fuel Volume"));
  parameter Integer FA=193 "Number of Fuel Assemblies" annotation(Dialog(group="Fuel Volume"));

protected
  parameter ThermoSysPro.Units.SI.Volume Vfuel=pi*Rp*Rp*Length*Rods_per_FA*FA "Volume of the fuel";
  parameter Modelica.Units.SI.NumberDensityOfMolecules fuel_moles_density = FuelDensity * 1000 / (OAtomicMass*2+FAtomicMass) * Modelica.Constants.N_A "Density of Fuel Oxyde Molecules";
  parameter Modelica.Units.SI.NumberDensityOfMolecules fissil_density = fuel_moles_density * Enrichment "Density of Fissil Atoms";

public
  constant Real pi=Modelica.Constants.pi "pi";
  constant Real OAtomicMass = 15.9949 "Oxygen atomic mass";
  constant ThermoSysPro.Units.SI.Frequency I_decay = 2.913e-5 "Decay constant of 135Iode" annotation(Dialog(group="Nuclear Data"));
  constant ThermoSysPro.Units.SI.Frequency Xe_decay = 2.116e-5 "Decay constant of 135Xenon" annotation(Dialog(group="Nuclear Data"));

  parameter Real FastFissionFactor = 1.07 "Fast Fission Factor" annotation(Dialog(group="Nuclear Data"));
  parameter ThermoSysPro.Units.SI.Area Fuel_Fission_CS = 5.82e-26 "Fuel thermal microscopic fission cross-section" annotation(Dialog(group="Nuclear Data"));
  parameter ThermoSysPro.Units.SI.Energy FissionEnergy = 3.2e-11 "Energy from each fission" annotation(Dialog(group="Nuclear Data"));
  parameter Real FAtomicMass = 235.04393 "Fissil atomic mass" annotation(Dialog(group="Nuclear Data"));
  parameter Real I_yield = 0.0632 "Total fission yield of 135Iode" annotation(Dialog(group="Nuclear Data"));
  parameter Real Xe_yield = 0.0026 "Total fission yield of 135Xenon" annotation(Dialog(group="Nuclear Data"));
  parameter ThermoSysPro.Units.SI.Area Xe_abs_CS = 2.75e-22 "Microscopic absorption cross-section of 135Xenon" annotation(Dialog(group="Nuclear Data"));

  ThermoSysPro.Units.SI.TotalNeutronSourceDensity FissionRate "Reactor Fission Rate";

  Real I_135 "Number of 135Iode nuclei";
  Real Xe_135 "Number of 135Xenon nuclei";
  ThermoSysPro.Units.SI.NeutronFluenceRate ThNeutronFlux "Neutron Flux (Thermal)";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Power(signal(
        start=3.8e9))
    "Thermal Power from fission [W]"
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Xe135
    annotation (Placement(transformation(extent={{72,-52},{92,-32}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal I135
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
  Xe135.signal = Xe_135;
  I135.signal = I_135;

  Power.signal / Vfuel = FissionEnergy * FissionRate;
  FissionRate = FastFissionFactor * ThNeutronFlux * Fuel_Fission_CS * fissil_density;

  der(I_135) = FissionRate*I_yield - I_135*I_decay;
  der(Xe_135) = FissionRate*Xe_yield + I_135*I_decay - Xe_135*Xe_decay - ThNeutronFlux*Xe_135*Xe_abs_CS;

  annotation (                                   Icon(graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-60,66},{60,-56}},
          lineColor={0,198,99},
          textStyle={TextStyle.Bold},
          textString="Xe")}), Documentation(info="# Xenon Evolution 

The Xenon evolution follows the following Bateman equations:

$$ \\frac{dI^{135}}{dt} = FissionRate * \\gamma_I - I^{135}  \\lambda_I $$

$$ \\frac{dXe^{135}}{dt} = FissionRate * \\gamma_{Xe} + I^{135}  \\lambda_I - Xe^{135}  \\lambda_{Xe} - \\Phi_{Th} Xe^{135} \\sigma_{Xe} $$

where \\\\(\\gamma\\\\) is the fission yield, \\\\(\\lambda\\\\) the decay constant, \\\\(\\Phi_{Th}\\\\) the thermal neutron flux 
and \\\\(\\sigma_{Xe}\\\\) the microscopic absorption cross section of the Xenon.

The *FissionRate* is computed from the thermal power:

$$  Power / Vfuel = FissionEnergy * FissionRate $$

and \\\\(\\Phi_{Th}\\\\) from the *FissionRate*, taking into account a small amount of fast fissions:

$$ FissionRate = FastFissionFactor * \\Phi_{Th} * \\sigma_f * N_f $$

where *FastFissionFactor* is the ratio between the total number of fissions and the thermal ones, \\\\(\\sigma_f\\\\) the microscopic fission cross-section of the fuel
and \\\\(N_f\\\\) the density of fissil atoms in the fuel.

The used microscopic cross-section values should refer to the thermal neutron flux."));
end Xenon;
