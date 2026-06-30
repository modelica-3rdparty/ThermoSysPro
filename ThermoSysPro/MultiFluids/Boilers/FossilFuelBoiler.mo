within ThermoSysPro.MultiFluids.Boilers;

model FossilFuelBoiler "Fossil fuel boiler"
  parameter Units.SI.Temperature Tsf = 400 "Flue gases temperature at the outlet";
  parameter Integer Boiler_efficiency_type = 1 "1: Taking into account LHV only - 2: Using the total incoming power";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Kf = 0.05 "Flue gases pressure loss coefficient";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Ke = 1e4 "Water/steam pressure loss coefficient";
  parameter Real etacomb = 1 "Combustion efficiency (between 0 and 1)";
  parameter Units.SI.Power Wloss = 1e5 "Thermal losses";
  parameter Integer mode = 0 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  Units.SI.MassFlowRate Qea(start = 400) "Air mass flow rate at the inlet";
  Units.SI.AbsolutePressure Pea(start = 1e5) "Air pressure at the inlet";
  Units.SI.Temperature Tea(start = 400) "Air temperature at the inlet";
  Units.SI.SpecificEnthalpy Hea(start = 50e3) "Air specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hrair(start = 10e3) "Air reference specific enthalpy";
  Real XeaCO2(start = 0) "CO2 mass fraction at the inlet";
  Real XeaH2O(start = 0.1) "H2O mass fraction at the inlet";
  Real XeaO2(start = 0.2) "O2 mass fraction at the inlet";
  Real XeaSO2(start = 0) "SO2 mass fraction at the inlet";
  Units.SI.MassFlowRate Qcomb(start = 5) "Fuel mass flow rate";
  Units.SI.Temperature Tcomb(start = 300) "Fuel temperature";
  Units.SI.SpecificEnthalpy Hcomb(start = 10e3) "Fuel specific enthalpy";
  Units.SI.SpecificEnthalpy Hrcomb(start = 10e3) "Fuel reference specific enthalpy";
  Real XCcomb(start = 0.8) "Carbon mass fraction";
  Real XHcomb(start = 0.2) "Hydrogen mass fraction";
  Real XOcomb(start = 0) "Oxygen mass fraction";
  Real XScomb(start = 0) "Sulfur mass fraction";
  Real PCIcomb(start = 5e7) "Fuel PCI (J/kg)";
  Units.SI.SpecificHeatCapacity Cpcomb(start = 2000) "Fuel specific heat capacity";
  Units.SI.MassFlowRate Qe(start = 100) "Water/steam mass flow rate";
  Units.SI.AbsolutePressure Pee(start = 50e5) "Water/steam pressure at the inlet";
  Units.SI.AbsolutePressure Pse(start = 50e5) "Water/steam pressure at the outlet";
  ThermoSysPro.Units.SI.PressureDifference deltaPe(start = 1e5) "Water/steam pressure losses";
  Units.SI.Temperature Tse(start = 500) "Water/steam temperature at the outlet";
  Units.SI.SpecificEnthalpy Hee(start = 400e3) "Water/steam specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hse(start = 400e3) "Water/steam specific enthalpy at the outlet";
  Units.SI.Density rhoe(start = 998) "Average water/steam density";
  Units.SI.MassFlowRate Qsf(start = 400) "Flue gases mass flow rate at the outlet";
  Units.SI.AbsolutePressure Psf(start = 1e5) "Flue gases pressure at the outlet";
  Units.SI.Temperature Tf(start = 1500) "Flue gases temperature after combustion";
  Units.SI.SpecificEnthalpy Hsf(start = 50e3) "Flue gases specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy Hf(start = 100e3) "Flue gases specific enthalpy after combustion";
  Units.SI.SpecificEnthalpy Hrfum(start = 10e3) "Flue gases reference specific enthalpy";
  ThermoSysPro.Units.SI.PressureDifference deltaPf(start = 1e3) "Pressure losses in the combusiton chamber";
  Units.SI.Density rhof(start = 0.05) "Flue gases density";
  Real XsfCO2(start = 0.2) "CO2 mass fraction at the outlet";
  Real XsfH2O(start = 0.15) "H2O mass fraction at the outlet";
  Real XsfO2(start = 0) "O2 mass fraction at the outlet";
  Real XsfSO2(start = 0) "SO2 mass fraction at the outlet";
  Units.SI.Power Wfuel(start = 5e8) "Fuel available power PCI";
  Units.SI.Power Wtot(start = 5e8) "Total incoming power";
  Units.SI.Power Wboil(start = 5e9) "Power exchanged in the boiler";
  Real eta_boil(start = 90) "Boiler efficiency (%) ";
  Real exc(start = 1) "Air combustion ratio";
  Real exc_air(start = 0.1) "Pertcentage of air in excess";
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel annotation(
    Placement(transformation(extent = {{-10, -90}, {10, -70}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cair annotation(
    Placement(transformation(extent = {{-110, -72}, {-90, -52}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg annotation(
    Placement(transformation(extent = {{90, -72}, {110, -52}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws1 annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cws2 annotation(
    Placement(transformation(extent = {{90, 50}, {110, 70}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros annotation(
    Placement(transformation(extent = {{-100, 84}, {-80, 104}}, rotation = 0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prom annotation(
    Placement(transformation(extent = {{80, 84}, {100, 104}}, rotation = 0)));
protected
  constant Real amC = 12.01115 "Carbon atomic mass";
  constant Real amH = 1.00797 "Hydrogen atomic mass";
  constant Real amO = 15.9994 "Oxygen atomic mass";
  constant Real amS = 32.064 "Sulfur atomic mass";
  constant Real amCO2 = amC + 2*amO "CO2 molecular mass";
  constant Real amH2O = 2*amH + amO "H2O molecular mass";
  constant Real amSO2 = amS + 2*amO "SO2 molecular mass";
  constant Real teps = 1e-6 "Small number";
  parameter Real eps = 1.e-0 "Small number for pressure loss equation";
  Real XeaO2c(start = 0.2) "Intermediate variable for the computation of the O2 mass fraction";
equation
/* Air inlet */
  Qea = Cair.Q;
  Pea = Cair.P;
  Tea = Cair.T;
  XeaCO2 = Cair.Xco2;
  XeaH2O = Cair.Xh2o;
  XeaO2 = Cair.Xo2;
  XeaSO2 = Cair.Xso2;
/* Fuel inlet */
  Qcomb = Cfuel.Q;
  Tcomb = Cfuel.T;
  XCcomb = Cfuel.Xc;
  XHcomb = Cfuel.Xh;
  XOcomb = Cfuel.Xo;
  XScomb = Cfuel.Xs;
  PCIcomb = Cfuel.LHV;
  Cpcomb = Cfuel.cp;
/* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Tsf = Cfg.T;
  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;
/* Water/steam inlet */
  Hee = Cws1.h;
  Pee = Cws1.P;
  Qe = Cws1.Q;
/* Water/steam outlet */
  Cws2.h = Hse;
  Cws2.P = Pse;
  Cws2.Q = Qe;
/* Flow reversal */
  0 = if (Qe > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;
/* Mass balance equation for the flue gases */
  Qsf = Qea + Qcomb;
/* CO2 flue gases composition */
  XsfCO2*Qsf = Qea*XeaCO2 + Qcomb*XCcomb*amCO2/amC;
/* H2O flue gases composition */
  XsfH2O*Qsf = Qea*XeaH2O + Qcomb*XHcomb*(amH2O/2)/amH;
/* O2 flue gases composition */
  XsfO2*Qsf = Qea*XeaO2c - Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS) + Qcomb*XOcomb;
/* SO2 flue gases composition */
  XsfSO2*Qsf = Qea*XeaSO2 + Qcomb*XScomb*amSO2/amS;
/* Combustion air ratio */
  exc = Qea*(1 - XeaH2O)/((Qcomb*amO*(2*XCcomb/amC + 0.5*XHcomb/amH + 2*XScomb/amS - XOcomb/amO))/(XeaO2c/(1 - XeaH2O)));
/* Air excess */
  exc_air = (exc - 1)*100;
/* Flue gases pressure losses */
  Pea - Psf = deltaPf;
  deltaPf = Kf*ThermoSysPro.Functions.ThermoSquare(Qsf, eps)/rhof;
/* Water/steam pressure losses */
  Pee - Pse = deltaPe;
  deltaPe = Ke*ThermoSysPro.Functions.ThermoSquare(Qe, eps)/rhoe;
/* Fuel specific enthalpy at the inlet */
  Hcomb = Cpcomb*Tcomb;
/* Energy balance equation for the flue gases */
  0 = (Qsf*(Hf - Hrfum) + Wloss) - (Qcomb*(Hcomb - Hrcomb + PCIcomb*etacomb) + Qea*(Hea - Hrair));
/* Fuel power */
  Wfuel = Qcomb*PCIcomb;
/* Total incoming power */
  Wtot = Qcomb*(Hcomb - Hrcomb + PCIcomb*etacomb) + Qea*(Hea - Hrair);
/* Power exchanged in the boiler */
  Wboil = Wtot - Qsf*(Hsf - Hrfum) - Wloss;
/* Water/steam specific enthalpy at the outlet */
  Hse = Wboil/Qe + Hee;
/* Boiler efficiency*/
  if (Boiler_efficiency_type == 1) then
    eta_boil = 100*Wboil/Wfuel;
  else
    eta_boil = 100*Wboil/Wtot;
  end if;
/* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
/* Flue gases tempretaure after combustion */
// Changed from FlueGases_T to FlueGases_h to provide a differentiable function
  Hf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
/* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
/* Flue gases density */
  rhof = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, (Tea + Tf)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  0 = if (XeaO2 > teps) then (XeaO2c - XeaO2) else (XeaO2c - teps);
/* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrcomb = 0;
  Hrfum = 2501.569e3*XsfH2O;
/* Water/steam thermodynamic properties */
  prom = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pee + Pse)/2, (Hee + Hse)/2, mode);
  rhoe = prom.d;
  pros = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode);
  Tse = pros.T;
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{0, -42}, {12, -46}, {22, -34}, {26, -20}, {24, -6}, {22, 2}, {18, 12}, {14, 22}, {12, 30}, {10, 36}, {6, 54}, {2, 44}, {-2, 36}, {-6, 24}, {-6, 20}, {-8, 16}, {-10, 24}, {-12, 26}, {-14, 22}, {-18, 14}, {-20, 8}, {-24, 0}, {-26, -10}, {-28, -20}, {-28, -28}, {-22, -36}, {-18, -42}, {-8, -48}, {0, -42}}, lineColor = {255, 0, 128}, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-8, -22}, {-6, -18}, {-2, -16}, {2, -16}, {6, -18}, {8, -20}, {10, -26}, {10, -30}, {8, -28}, {6, -24}, {4, -20}, {-2, -20}, {-4, -22}, {-8, -26}, {-10, -28}, {-10, -28}, {-8, -22}}, lineColor = {127, 0, 0}, fillColor = {127, 0, 0}, fillPattern = FillPattern.Solid)}),
    Icon(graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-2, -42}, {10, -46}, {20, -34}, {24, -20}, {22, -6}, {20, 2}, {16, 12}, {12, 22}, {10, 30}, {8, 36}, {4, 54}, {0, 44}, {-4, 36}, {-8, 24}, {-8, 20}, {-10, 16}, {-12, 24}, {-14, 26}, {-16, 22}, {-20, 14}, {-22, 8}, {-26, 0}, {-28, -10}, {-30, -20}, {-30, -28}, {-24, -36}, {-20, -42}, {-10, -48}, {-2, -42}}, lineColor = {255, 0, 128}, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-10, -24}, {-8, -20}, {-4, -18}, {0, -18}, {4, -20}, {6, -22}, {8, -28}, {8, -32}, {6, -30}, {4, -26}, {2, -22}, {-4, -22}, {-6, -24}, {-10, -28}, {-12, -30}, {-12, -30}, {-10, -24}}, lineColor = {127, 0, 0}, fillColor = {127, 0, 0}, fillPattern = FillPattern.Solid)}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 7.2 of the ThermoSysPro book.   

# Fossil fuel boiler  

The boiler is the most complex subsystem of a power plant.  
It is split into a pair of interacting circuits: the water/steam circuit and the flue gases circuit.  
There are different components present in flue gases and water/steam circuits: boiler furnace with membrane water-walls, heat exchangers, drums, headers, volumes, mixers, splitters, and valves.  

## Modelica component model  

The equations mentioned below are implemented in the component *FossilFuelBoiler*, located in the *MultiFluids.Boilers* sub-library.  
The component has 5 connectors:  
- Cws1: water/steam flow at the inlet,  
- Cws2: water/steam flow at the outlet,  
- Cair: air at the inlet,  
- Cfuel: fuel at the inlet,  
- Cfg: flue gases at the outlet.   

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.MultiFluids.Boilers.FossilFuelBoiler.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.MultiFluids.Boilers.FossilFuelBoiler.svg)  

## Nomenclature  


| Symbol          | Description                                                         | Unit  | Definition | Modelica name |  
|------------------- |---------------------------------------------------------- |---------------------------|------------------------------------- |  :--------------- |  
| \\\\( c_{p, f} \\\\)        | Fuel specific heat capacity | \\\\( \\mathrm{J/kg/K} \\\\) |     | Cpcomb |  
| \\\\(E_x \\\\) | Dry air stoichiometry necessary for 1kg fuel combustion | - | Proportion of oxygen in the air at the inlet required to burn 1kg of fuel | - |  
| \\\\(E_{X,a} \\\\) | Excess air | \\\\(\\% \\\\) | \\\\( 100 \\cdot \\left( \\frac{\\dot{m}\\_a \\cdot (1 - X_{h_2O, a})}{\\dot{m}\\_f \\cdot E_X} - 1 \\right) \\\\) | exc_air |  
| \\\\( h_{a, i} \\\\) | Air specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | | Hea |  
| \\\\(\\tilde{h}_{a, r} \\\\) | Air reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | \\\\(2501569 \\cdot X_{h_2O, a} \\\\) | Hrair |  
| \\\\( h_{f} \\\\) | Fuel specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | \\\\(c_{p, f} \\cdot (T_f - 273.16) \\\\) | Hcomb |  
| \\\\( \\tilde{h}_{f, r} \\\\) | Fuel reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | 0 | Hrcomb |  
| \\\\( h_{g} \\\\) | Flue gases specific enthalpy after combustion | \\\\(\\mathrm{J/kg} \\\\) | | Hf |  
| \\\\( h_{g, o} \\\\) | Flue gases specific enthalpy at the outlet | \\\\(\\mathrm{J/kg} \\\\) | | Hsf |  
| \\\\( \\tilde{h}_{g, r} \\\\) | Flue gases reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |\\\\(2501569 \\cdot X_{h_2O, g} \\\\) | Hrfum |  
| \\\\( h_{ws, i} \\\\) | Water/steam specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | | Hee |  
| \\\\( h_{ws, o} \\\\) | Water/steam specific enthalpy at the outlet | \\\\(\\mathrm{J/kg} \\\\) | | Hse |  
| LHV | Fuel lower heating value | \\\\(\\mathrm{J/kg} \\\\) | | Cfuel.LHV |  
| \\\\(\\dot{m}_a \\\\) | Air mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qea |  
| \\\\(\\dot{m}_f \\\\) | Fuel mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qcomb |  
| \\\\(\\dot{m}_g \\\\) | Flue gases mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qsf |  
| \\\\(\\dot{m}_{ws} \\\\) | Water/steam mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qe |  
| \\\\( M_C \\\\) | Carbon atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 12.01115 | amC |  
| \\\\( M_H \\\\) | Hydrogen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 1.00797 | amH |  
| \\\\( M_O \\\\) | Oxygen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 15.9994 | amO |  
| \\\\( M_S \\\\) | Sulfur atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 32.064 | amS |  
| \\\\( M_{CO_2} \\\\) | \\\\(CO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_C + 2 \\cdot M_O \\\\) | amCO2 |  
| \\\\( M_{H_2O} \\\\) | \\\\(H_2O\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_O + 2 \\cdot M_H \\\\) | amH2O |  
| \\\\( M_{SO_2} \\\\) | \\\\(SO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_S + 2 \\cdot M_O \\\\) | amSO2 |  
| \\\\( P_{g,i} \\\\) | Air pressure at the inlet | \\\\(\\mathrm{Pa} \\\\) | | Pea |  
| \\\\( P_{g,o} \\\\) | Flue gases pressure at the outlet | \\\\(\\mathrm{Pa} \\\\) | | Psf |  
| \\\\( P_{ws,i} \\\\) | Water/steam pressure at the inlet | \\\\(\\mathrm{Pa} \\\\) | | Pee |  
| \\\\( P_{ws,o} \\\\) | Water/steam pressure at the outlet | \\\\(\\mathrm{Pa} \\\\) | | Pse |  
| \\\\( T_{a,i} \\\\) | Air temperature at the inlet | \\\\(\\mathrm{K} \\\\) | | Tea |  
| \\\\( T_{f} \\\\) | Fuel temperature at the inlet | \\\\(\\mathrm{K} \\\\) | | Tcomb |  
| \\\\( T_{g,o} \\\\) | Flue gases temperature at the outlet | \\\\(\\mathrm{K} \\\\) | | Cfg.T |  
| \\\\( T_{g} \\\\) | Flue gases temperature after combustion | \\\\(\\mathrm{K} \\\\) | | Tf |  
| \\\\( W_l \\\\) | Thermal losses | \\\\(\\mathrm{W} \\\\) | | Wloss |  
| \\\\( X_{C,f} \\\\) | Carbon mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XCcomb |  
| \\\\( X_{H,f} \\\\) | Hydrogen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XHcomb |  
| \\\\( X_{O,f} \\\\) | Oxygen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XOcomb |  
| \\\\( X_{S,f} \\\\) | Sulfur mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XScomb |  
| \\\\( X_{CO_2,a} \\\\) | \\\\( CO_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaCO2 |  
| \\\\( X_{CO_2,g} \\\\) |  \\\\( CO_2 \\\\)  mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) | | XsfCO2 |  
| \\\\( X_{H_2O,a} \\\\) | \\\\( H_2O \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaH2O |  
| \\\\( X_{H_2O,g} \\\\) | \\\\( H_2O \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfH2O |  
| \\\\( X_{O_2,a} \\\\) | \\\\( O_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaO2 |  
| \\\\( X_{O_2,g} \\\\) | \\\\( O_2 \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfO2 |  
| \\\\( \\eta \\\\) | Boiler efficiency \\\\( 0 < \\eta \\le 1 \\\\) | \\\\(\\mathrm{-} \\\\) | Net thermal power at the outlet divided by the total thermal power at the inlet | eta_boil |  
| \\\\( \\eta_c \\\\) | Combustion efficiency \\\\( 0 < \\eta_c \\le 1 \\\\) | \\\\(\\mathrm{-} \\\\) | Burnt fuel mass divided by the input fuel mass | etacomb |  
| \\\\( \\Lambda_g \\\\) | Flue gases pressure loss coefficient | \\\\(\\mathrm{m}^{-4} \\\\) | | Kf |  
| \\\\( \\Lambda_{ws} \\\\) | Water/steam pressure loss coefficient | \\\\(\\mathrm{m}^{-4} \\\\) | | Ke |  
| \\\\( \\rho_g \\\\) | Flue gases density | \\\\(\\mathrm{kg/m}^3 \\\\) | | rhof |  
| \\\\( \\rho_{ws} \\\\) | Water/steam density | \\\\(\\mathrm{kg/m}^3 \\\\) | | rhoe |  



## Governing equations  

The *FossilFuelBoiler* model is based on the energy and momentum balance equations.   
This set of equations must be completed by the state equations involving \\\\( h_{a,i}, \\\\, h_{g,o}, \\\\, T_g, \\\\, \\rho_g \\\\; \\text{and} \\\\; \\rho_{ws} \\\\).  


### Mass balance equation for the flue gases  

- Validity domain:   
   
  \\\\( \\forall \\dot{m}\\_g \\\\, , \\dot{m}\\_a \\\\; \\\\text{and} \\\\; \\dot{m}\\_f \\\\)  

- Mathematical formulation:  

$$\\dot{m}\\_g = \\dot{m}\\_a + \\dot{m}\\_f $$  

- Comments:  
      
Flue gases result from the combustion of fuel with air. If the combustion is not perfect (i.e. \\\\( \\eta_c < 1 \\\\) ), there is unburnt fuel in the exhaust flue gases.  


### Energy balance equation for the flue gases  

- Validity domain:   
   
  \\\\( \\forall \\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\; \\text{and} \\\\; \\dot{m}\\_g>0 \\\\)  

- Mathematical formulation:  

$$ \\dot{m}\\_g \\cdot h_g = \\dot{m}\\_a \\cdot h_{a,i} + \\dot{m}\\_f \\cdot (h_f + \\eta_c \\cdot LHV) - W_l $$  

- Comments:  
      
This equation is used to compute the flue gases specific enthalpy after combustion \\\\( h_g \\\\).  
The combustion efficiency \\\\(\\eta_c \\\\) and the fuel lower heating value LHV are model inputs.  
The specific enthalpies \\\\( h_f \\\\) and \\\\( h_{a,i} \\\\) are computed using properties tables from the known temperatures \\\\(T_f \\\\) and \\\\(T_{a,i} \\\\).  


### Power exchanged in the boiler between flue gases and water/steam circuits  

- Validity domain:   
   
  \\\\( \\forall \\dot{m}\\_g \\\\, , \\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\; \\\\text{and} \\\\;\\\\ \\dot{m}\\_{ws} \\neq 0 \\\\)  

- Mathematical formulation:   

$$ \\dot{m}\\_a \\cdot h_{a,i} + \\dot{m}\\_f \\cdot (h_f + \\eta_c \\cdot LHV) - W_l - \\dot{m}\\_g \\cdot h_{g,o} = \\dot{m}\\_{ws} \\cdot (h_{ws,o} - h_{ws,i}) $$  

- Comments:  
      
This equation computes the water/steam specific enthalpy at the outlet \\\\( h_{ws,o} \\\\).  


### Boiler efficiency  

- Validity domain:   
   
 \\\\(  \\dot{m}\\_a > 0 \\\\; \\\\text{and} \\\\;\\\\ \\dot{m}\\_f > 0 \\\\)  

- Mathematical formulation:   

$$ \\eta = 100 \\cdot \\frac{\\dot{m}\\_{ws} \\cdot (h_{ws,o} - h_{ws,i})}{ \\dot{m}\\_a \\cdot h_{a,i} + \\dot{m}\\_f \\cdot (h_f + LHV)} $$  

- Comments:  
      
Another possible definition for the efficiency only takes into account the fuel LHV:  

$$ \\eta = 100 \\cdot \\frac{\\dot{m}\\_{ws} \\cdot (h_{ws,o} - h_{ws,i})}{\\dot{m}\\_f \\cdot LHV} $$  


### Momentum balance equation for the flue gases  

- Validity domain:   
   
 \\\\( \\forall \\dot{m}\\_f \\\\)  

- Mathematical formulation:   

$$ P_{f,o} = P_{f,i} - \\Lambda_f \\cdot \\frac{\\dot{m}\\_f \\cdot |\\dot{m}\\_f|}{\\rho_f} $$  

- Comments:  
      

### Momentum balance equation for the water/steam  

- Validity domain:   
   
 \\\\(  \\dot{m}\\_a > 0 \\\\; \\\\text{and} \\\\;\\\\ \\dot{m}\\_f > 0 \\\\)  

- Mathematical formulation:   
      
$$ P_{w,o} = P_{w,i} - \\Lambda_{ws} \\cdot \\frac{\\dot{m}\\_{ws} \\cdot |\\dot{m}\\_{ws}|}{\\rho_{ws}} $$  

- Comments:  


### Dry air stoichiometry for the combustion of 1 kg fuel  

- Validity domain:   
   
 \\\\( X_{H_20,a} < 1 \\\\; \\\\text{and} \\\\;\\\\ X_{O_2,a} > 0 \\\\)  

- Mathematical formulation:   
      
$$ E_X = M_O \\cdot \\frac{\\frac{2 \\cdot X_{C,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} - \\frac{X_{O,f}}{M_O}}{\\frac{X_{0_2,a}}{1 - X_{H_2O,a}}} $$  

- Comments:  

This formulation arises from the chemical reactions considered in the combustion:  

\\\\( C + O_2 \\longrightarrow CO_2 \\\\)  

\\\\( H + \\frac{1}{4} 0_2 \\longrightarrow H_2O \\\\)  

\\\\( S + O_2 \\longrightarrow SO_2 \\\\)  


### \\\\( CO_2 \\\\) mass fraction in the flue gases  

- Validity domain:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{CO_2,g} = \\frac{\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{CO_2,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{C,f} \\cdot \\frac{M_{CO_2}}{M_C} $$  

- Comments:  

This formulation arises from the chemical reaction considered in the combustion:  

$$ C + O_2 \\longrightarrow CO_2 $$  


### \\\\( H_2O \\\\) mass fraction in the flue gases  

- Validity domain:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{H_2O,g} = \\frac{\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{H_2O,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{H,f} \\cdot \\frac{M_{H_2O}}{2 \\cdot M_H} $$  

- Comments:  

This formulation arises from the chemical reaction considered in the combustion:  

$$ H + \\frac{1}{4} O_2 \\longrightarrow H_2O $$  


### \\\\( O_2 \\\\) mass fraction in the flue gases  

- Validity domain:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{O_2,g} = \\frac{\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{O_2,a} - M_O \\cdot \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot \\left( \\frac{2 \\cdot X_{HC,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} \\right) + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{O,f} $$  

- Comments:  

This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  


### \\\\( SO_2 \\\\) mass fraction in the flue gases  

- Validity domain:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{SO_2,g} = \\frac{\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{SO_2,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{S,f} \\cdot \\frac{M_{SO_2}}{M_S}$$  

- Comments:  

This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  

## References  

-   El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1). Springer Nature Switzerland AG.  
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 7.2. Springer Nature Switzerland AG.  
    "));
end FossilFuelBoiler;