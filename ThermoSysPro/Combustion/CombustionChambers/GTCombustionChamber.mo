within ThermoSysPro.Combustion.CombustionChambers;

model GTCombustionChamber "Gas turbine combustion chamber"
  parameter Real kcham = 1 "Pressure loss coefficient in the combustion chamber";
  parameter Units.SI.Area Acham = 1 "Average corss-sectional area of the combusiton chamber";
  parameter Real eta_comb = 1 "Combustion efficiency";
  parameter Units.SI.Power Wpth = 1e6 "Thermal loss fraction in the body of the combustion chamber";
  parameter Boolean air_atomisation = false "true: computation with air atomisation - false: computation without air atomisation";
  parameter Units.SI.Temperature Tecpat = 293 "Temperature at the inlet of the atomisation compressor";
  parameter Real kat = 0 "Atomisation pressure loss coefficient";
  parameter Real XQat = 0 "Atomisation air mass flow rate coefficient";
  parameter Real Xspat = 0 "Atomisation over-pressure coefficient";
  parameter Real eta_is = 1 "Atomisation compressor isentropic efficiency";
  Units.SI.MassFlowRate Qea(start = 400) "Air mass flow rate";
  Units.SI.AbsolutePressure Pea(start = 1e5) "Air pressure at the inlet";
  Units.SI.Temperature Tea(start = 600) "Air temperature at the inlet";
  Units.SI.SpecificEnthalpy Hea(start = 50e3) "Air specific enthalpy at the inlet";
  Real XeaCO2(start = 0) "CO2 mass fraction at the air inlet";
  Real XeaH2O(start = 0.1) "H2O mass fraction at the air inlet";
  Real XeaO2(start = 0.2) "O2 mass fraction at the air inlet";
  Real XeaSO2(start = 0) "SO2 mass fraction at the air inlet";
  Units.SI.MassFlowRate Qfuel(start = 5) "Fuel mass flow rate";
  Units.SI.Temperature Tfuel(start = 300) "Fuel temperature";
  Units.SI.SpecificEnthalpy Hfuel(start = 10e3) "Fuel specific enthalpy";
  Real XCfuel(start = 0.8) "C mass fraction in the fuel";
  Real XHfuel(start = 0.2) "H mass fraction in the fuel";
  Real XOfuel(start = 0) "O mass fraction in the fuel";
  Real XSfuel(start = 0) "S mass fraction in the fuel";
  Units.SI.SpecificEnergy LHVfuel(start = 5e7) "Fuel lower heating value";
  Units.SI.SpecificHeatCapacity Cpfuel(start = 1000) "Fuel specific heat capacity";
  Units.SI.MassFlowRate Qews(start = 1) "Water/steam mass flow rate";
  Units.SI.SpecificEnthalpy Hews(start = 10e3) "Water/steam specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qsf(start = 400) "Flue gases mass flow rate";
  Units.SI.AbsolutePressure Psf(start = 12e5) "Flue gases pressure at the outlet";
  Units.SI.Temperature Tsf(start = 1500) "Flue gases temperature at the outlet";
  Units.SI.SpecificEnthalpy Hsf(start = 50e4) "Flue gases specific enthalpy at the outlet";
  Real XsfCO2(start = 0.5) "CO2 mass fraction in the flue gases";
  Real XsfH2O(start = 0.1) "H2O mass fraction in the flue gases";
  Real XsfO2(start = 0) "O2 mass fraction in the flue gases";
  Real XsfSO2(start = 0) "SO2 mass fraction in the flue gases";
  Units.SI.Power Wfuel(start = 5e8) "LHV power available in the fuel";
  Real exc(start = 1) "Combustion air ratio";
  ThermoSysPro.Units.SI.PressureDifference deltaPccb(start = 1e3) "Pressure loss in the combusiton chamber";
  Units.SI.SpecificEnthalpy Hrair(start = 10e3) "Air reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrws(start = 10e4) "Water/steam reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfuel(start = 10e3) "Fuel reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfg(start = 10e3) "Flue gases reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hecpat(start = 10e3) "Air specific enthalpy at the inlet of the atomisaiton compressor";
  Units.SI.SpecificEnthalpy Hiscpat(start = 10e3) "Air specific enthalpy after isentropic expansion at the outlet of the atomisaiotn compressor";
  Units.SI.AbsolutePressure Pecpat(start = 1e5) "Pressure at the inlet of the atomisation compressor";
  Units.SI.AbsolutePressure Pscpat(start = 1e5) "Pressure at the outlet of the atomisation compressor";
  Units.SI.SpecificEntropy Secpat(start = 1e3) "Entropy at the inlet of the atomisation compressor";
  Units.SI.MassFlowRate Qm(start = 400) "Average mass flow rate in the combustion chamber";
  Real Vea(start = 0.001) "Air volume mass (m3/kg)";
  Real Vsf(start = 0.001) "Flue gases volume mass (m3/kg)";
  Units.SI.Density rhoea(start = 0.001) "Air density at the inlet";
  Units.SI.Density rhosf(start = 0.001) "Flue gases density at the outlet";
  Real Vccbm(start = 0.001) "Average volume mass in the combustion chamber";
  Units.SI.Velocity v(start = 100) "Flue gases reference velocity in the combusiton chamber";
  Units.SI.Power Wcpat(start = 1e3) "Power of the atomisation compressor";
  Units.SI.Power Wrfat(start = 1e3) "Thermal power extracted by the atomisaiton refrigerant";
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel "Fuel inlet" annotation(
    Placement(transformation(extent = {{-10, -100}, {10, -80}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ca "Air inlet" annotation(
    Placement(transformation(extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg "Flue gases outlet" annotation(
    Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws "Water/steam inlet" annotation(
    Placement(transformation(extent = {{-70, 80}, {-50, 100}}, rotation = 0)));
protected
  constant Real amC = 12.01115 "Carbon atomic mass";
  constant Real amH = 1.00797 "Hydrogen atomic mass";
  constant Real amO = 15.9994 "Oxygen atomic mass";
  constant Real amS = 32.064 "Sulfur atomic mass";
  constant Real eps_a = 1e-6 "Zero criterion for a-dimensional numbers";
  constant Real eps_s = 1e-6 "Zero criterion for surface numbers";
  Real amCO2 "CO2 molecular mass";
  Real amH2O "H2O molecular mass";
  Real amSO2 "SO2 molecular mass";
  Real eta_isc(start = 1) "Intermediate variable for the computation of the isentropic efficiency of the atomisaiton compressor";
  Units.SI.Area Achamc(start = 1) "Intermediate variable for the computation of the average corss-section aera of the combusion chamber";
  Real XeaO2c(start = 0.2) "Intermediate variable for the computation of the O2 mass fraction";
equation
/* Air inlet */
  Qea = Ca.Q;
  Pea = Ca.P;
  Tea = Ca.T;
  XeaCO2 = Ca.Xco2;
  XeaH2O = Ca.Xh2o;
  XeaO2 = Ca.Xo2;
  XeaSO2 = Ca.Xso2;
/* Fuel inlet */
  Qfuel = Cfuel.Q;
  Tfuel = Cfuel.T;
  XCfuel = Cfuel.Xc;
  XHfuel = Cfuel.Xh;
  XOfuel = Cfuel.Xo;
  XSfuel = Cfuel.Xs;
  LHVfuel = Cfuel.LHV;
  Cpfuel = Cfuel.cp;
/* Water inlet */
  Qews = Cws.Q;
  Hews = Cws.h;
  Cws.h = Cws.h_vol;
/* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Tsf = Cfg.T;
  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;
/* Specific enthalpy and entropy at the inlet of the atomisaiton compressor */
  if air_atomisation then
    Hecpat = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pecpat, Tecpat, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
    Secpat = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pecpat, Tecpat, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
    Hiscpat = ThermoSysPro.Properties.FlueGases.FlueGases_h_Ps(Pscpat, Secpat, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
  else
    Hecpat = 60000;
    Secpat = -2000;
    Hiscpat = 60000;
  end if;
/* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
/* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
/* Air density at the inlet */
  rhoea = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, Tea, XeaCO2, XeaH2O, XeaO2c, XeaSO2);
  Vea = if (rhoea > 0.001) then 1/rhoea else 1/1.1;
/* Flue gases density at the outlet */
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  Vsf = if (rhosf > 0.001) then 1/rhosf else 1/0.1;
  0 = if (eta_is > eps_a) then (eta_isc - eta_is) else (eta_isc - eps_a);
  0 = if (Acham > eps_s) then (Achamc - Acham) else (Achamc - eps_s);
  0 = if (XeaO2 > eps_a) then (XeaO2c - XeaO2) else (XeaO2c - eps_a);
  amCO2 = amC + 2*amO;
  amH2O = 2*amH + amO;
  amSO2 = amS + 2*amO;
/* Mass balance equation */
  Qsf = Qea + Qews + Qfuel;
/* CO2 flue gases mass fraction */
  XsfCO2*(Qea + Qews + Qfuel) = (Qea*XeaCO2) + (Qfuel*XCfuel*amCO2/amC);
/* H2O flue gases mass fraction */
  XsfH2O*(Qea + Qews + Qfuel) = (Qews) + (Qea*XeaH2O + Qfuel*XHfuel*amH2O/2/amH);
/* O2 flue gases mass fraction */
  XsfO2*(Qea + Qews + Qfuel) = (Qea*XeaO2c) - (Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS)) + (Qfuel*XOfuel);
/* SO2 flue gases mass fraction */
  XsfSO2*(Qea + Qews + Qfuel) = (Qea*XeaSO2) + (Qfuel*XSfuel*amSO2/amS);
/* Fuel thermal power */
  Wfuel = Qfuel*LHVfuel;
/* Combusiton air ratio */
  exc = Qea*(1 - XeaH2O)/((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO))/(XeaO2c/(1 - XeaH2O)));
/* Pressure losses */
  Pea - Psf = deltaPccb;
  Qm = Qea + (Qfuel + Qews)/2;
  Vccbm = (Vea + Vsf)/2;
  v = Qm*Vccbm/Achamc;
  deltaPccb = (kcham*(v^2))/(2*Vccbm);
/* Fuel specific enthalpy at the inlet */
  Hfuel = Cpfuel*(Tfuel - 273.16);
  if air_atomisation then
/* Energy balance equation */
    ((Qea + Qews + Qfuel)*(Hsf - Hrfg) + Wrfat + Wpth) - (Qfuel*(Hfuel - Hrfuel + LHVfuel*eta_comb) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws) + Wcpat) = 0;
/* Atomisation power */
    Pecpat = Pea*(1 - kat);
    Pscpat = (1 + Xspat)*Pea;
    Wcpat = Qea*XQat*(Hiscpat - Hecpat)*eta_isc;
/* Heat extracted by the atomisaiotn refrigerant */
    Wrfat = Qea*XQat*(Hea - Hecpat);
  else
/* Energy balance equation */
    ((Qea + Qews + Qfuel)*(Hsf - Hrfg) + Wpth) - (Qfuel*(Hfuel - Hrfuel + LHVfuel*eta_comb) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws)) = 0;
/* Atomisation power */
    Pecpat = Pea;
    Pscpat = Pea;
    Wcpat = 0;
/* Heat extracted by the atomisaiotn refrigerant */
    Wrfat = 0;
  end if;
/* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrfuel = 0;
  Hrws = 2501.569e3;
  Hrfg = 2501.569e3*XsfH2O;
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {120, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-20, 80}, {-20, -80}}, color = {0, 0, 255}), Polygon(points = {{-20, 62}, {46, 46}, {2, 30}, {58, 18}, {6, 0}, {48, -16}, {2, -32}, {54, -44}, {-20, -60}, {-20, 62}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.CrossDiag)}),
    Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {120, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-20, 80}, {-20, -80}}, color = {0, 0, 255}), Polygon(points = {{-20, 62}, {46, 46}, {2, 30}, {58, 18}, {6, 0}, {48, -16}, {2, -32}, {54, -44}, {-20, -60}, {-20, 62}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.CrossDiag)}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 8.1 of the ThermoSysPro book.   
# GT combustion chamber  

This component is a combustion chamber for a gas turbine.  
A gas turbine is a type of internal combustion engine.  
It is composed of an upstream compressor, a combustion chamber and a downstream turbine.  
At the inlet, air is compressed, up to 30 times the atmospheric pressure.  
In the combustion chamber, it is mixed with fuel, which launches the combustion.  
The expansion of hot gases bring the turbine in rotation, producing electricity.  

## Modelica component model  

The equations mentioned below are implemented in the component *GTCombustionChamber*, located in the *Combustion.CombustionChambers* sub-library.  
The component has 4 connectors:  
- Cws: water/steam at the inlet,  
- Ca: air at the inlet,  
- Cfuel: fuel at the inlet,  
- Cfg: flue gases at the outlet.  

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Combustion.CombustionChambers.GTCombustionChamber.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Combustion.CombustionChambers.GTCombustionChamber.svg)  

## Nomenclature  


| Symbol          | Description                                                         | Unit                          | Definition                | Modelica name |  
|------------------- |---------------------------------------------------------- |---------------------------|------------------------------------- |-------------------------|  
| A | Average cross-sectional area of the combustion chamber | \\\\( \\mathrm{m}^2 \\\\) || Acham |  
| \\\\( c_{p, f} \\\\)        | Fuel specific heat capacity | \\\\( \\mathrm{J/kg/K} \\\\) |     | Cpfuel |  
| \\\\(E_x \\\\) | Dry air stoichiometry necessary for 1kg fuel combustion | - | Proportion of oxygen in the air at the inlet required to burn 1kg fuel | - |  
| \\\\(E_{X,a} \\\\) | Excess air | \\\\(\\% \\\\) | \\\\( 100 \\cdot \\left(\\frac{\\dot{m}\\_a \\cdot (1 - X_{h_2O, a})}{\\dot{m}\\_f \\cdot E_X} - 1 \\right) \\\\) | - |  
| \\\\( h\\_{a, i} \\\\) | Air specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | |  Hea |  
| \\\\(\\tilde{h}_{a, r} \\\\) | Air reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | \\\\(2501569 \\cdot X_{h_2O, a} \\\\) | Hrair |  
| \\\\( h\\_{at,i} \\\\) | Air specific enthalpy at the inlet of the atomization compressor | \\\\( \\mathrm{J/kg} \\\\) | | Hecpat |  
| \\\\( h\\_{at,o} \\\\) | Air specific enthalpy at the outlet of the atomization compressor | \\\\( \\mathrm{J/kg} \\\\) | | - |  
| \\\\( h_{f} \\\\) | Fuel specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | \\\\(c_{p, f} \\cdot (T_f - 273.16) \\\\) | Hfuel |  
| \\\\( \\tilde{h}_{f, r} \\\\) | Fuel reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | 0 | Hrfuel |  
| \\\\( h_{g, o} \\\\) | Flue gases specific enthalpy at the outlet | \\\\(\\mathrm{J/kg} \\\\) | | Hsf |  
| \\\\( \\tilde{h}_{g, r} \\\\) | Flue gases reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |\\\\(2501569 \\cdot X_{h_2O, g} \\\\) | Hrfg |  
| \\\\( h_{ws, i} \\\\) | Water/steam specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | | Hews |  
| \\\\( h_{ws, r} \\\\) | Water/steam reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |2501569 | Hrws |  
| LHV | Fuel lower heating value | \\\\(\\mathrm{J/kg} \\\\) | | LHVfuel |  
| \\\\(\\dot{m}\\_a \\\\) | Air mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qea |  
| \\\\(\\\\dot{m}\\_f \\\\) | Fuel mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qfuel |  
| \\\\(\\dot{m}\\_g \\\\) | Flue gases mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qsf |  
| \\\\(\\dot{m}\\_m \\\\) | Average mass flow rate in the combustion chamber| \\\\(\\mathrm{kg/s} \\\\) | \\\\(\\dot{m}\\_a + \\frac{\\\\dot{m}\\_f + \\\\dot{m}\\_{ws}}{2} \\\\)| Qm |  
| \\\\(\\\\dot{m}\\_{ws} \\\\) | Water/steam mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | | Qews |  
| \\\\( M_C \\\\) | Carbon atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 12.01115 | amC |  
| \\\\( M_H \\\\) | Hydrogen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 1.00797 | amH |  
| \\\\( M_O \\\\) | Oxygen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 15.9994 | amO |  
| \\\\( M_S \\\\) | Sulfur atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 32.064 | amS |  
| \\\\( M_{CO_2} \\\\) | \\\\(CO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_C + 2 \\cdot M_O \\\\) | amCO2 |  
| \\\\( M_{H_2O} \\\\) | \\\\(H_2O\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_O + 2 \\cdot M_H \\\\) | amH2O |  
| \\\\( M_{SO_2} \\\\) | \\\\(SO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_S + 2 \\cdot M_O \\\\) | amSO2 |  
| \\\\( P_{at,i} \\\\) | Pressure at the inlet of the atomization compressor | \\\\( \\mathrm{Pa} \\\\) | With air atomization: \\\\( P_{at,i} = P_i \\cdot (1 - \\Lambda_{at}) \\\\), else: \\\\( P_{at,i} = P_i \\\\). | Pecpat |  
| \\\\( P_{at,o} \\\\) | Pressure at the outlet of the atomization compressor | \\\\( \\mathrm{Pa} \\\\) | With air atomization: \\\\( P_{at,i} = P_i \\cdot (1 + XP_{at}) \\\\), else: \\\\( P_{at,i} = P_i \\\\). | Pscpat |  
| \\\\( P_i \\\\) | Fluid pressure at the inlet | \\\\(\\mathrm{Pa} \\\\) | | Pea |  
| \\\\( P_o \\\\) | Fluid pressure at the outlet | \\\\(\\mathrm{Pa} \\\\) | | Psf |  
| \\\\( S_{at,i} \\\\) | Entropy at the inlet of the atomization compressor | \\\\( \\mathrm{J/kg/K} \\\\)| | Secpat |  
| \\\\( T_{a,i} \\\\) | Air temperature at the inlet | \\\\(\\mathrm{K} \\\\) | | Tea |  
| \\\\( T_{at} \\\\) | Temperature at the inlet of the atomization compressor | \\\\(\\mathrm{K} \\\\) | | Tecpat |  
| \\\\( T_{f} \\\\) | Fuel temperature at the inlet | \\\\(\\mathrm{K} \\\\) | | Tfuel |  
| \\\\( T_{g,o} \\\\) | Flue gases temperature at the outlet | \\\\(\\mathrm{K} \\\\) | | Tsf |  
| \\\\( \\nu \\\\) | Flue gases velocity in the combustion chamber | \\\\( \\mathrm{m/s} \\\\) | \\\\( \\frac{\\\\dot{m}\\_m}{A \\cdot \\rho_m} \\\\) | v |  
| \\\\( W_{at} \\\\) | Power of the atomization compressor | \\\\( \\mathrm{W} \\\\) | | Wcpat |  
| \\\\( W_{at,o} \\\\) | Thermal power extracted by the atomization refrigerant | \\\\( \\mathrm{W} \\\\) | | Wrfat |  
| \\\\( W_f \\\\) | LHV power available in the fuel | \\\\( \\mathrm{W} \\\\) | \\\\( \\\\dot{m}\\_f \\cdot LHV \\\\) | Wfuel |  
| \\\\( W_l \\\\) | Thermal losses | \\\\(\\mathrm{W} \\\\) | | Wpth |  
| \\\\( X_{C,f} \\\\) | Carbon mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XCfuel |  
| \\\\( X_{H,f} \\\\) | Hydrogen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XHfuel |  
| \\\\( X_{O,f} \\\\) | Oxygen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XOfuel |  
| \\\\( X_{S,f} \\\\) | Sulfur mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XSfuel |  
| \\\\( X_{CO_2,a} \\\\) | \\\\( CO_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaCO2 |  
| \\\\( X_{CO_2,g} \\\\) |  \\\\( CO_2 \\\\)  mass fraction in the flue gasess | \\\\(\\mathrm{-} \\\\) | | XsfCO2 |  
| \\\\( X_{H_2O,a} \\\\) | \\\\( H_2O \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaH2O |  
| \\\\( X_{H_2O,g} \\\\) | \\\\( H_2O \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfH2O |  
| \\\\( X_{O_2,a} \\\\) | \\\\( O_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaO2 |  
| \\\\( X_{O_2,g} \\\\) | \\\\( O_2 \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfO2 |  
| \\\\( XM_{at} \\\\) | Atomization air mass flow rate coefficient |  \\\\(\\mathrm{-} \\\\) || XQat |  
| \\\\( XP_{at} \\\\) | Atomization overpressure coefficient |  \\\\(\\mathrm{-} \\\\) || Xspat |  
| \\\\( \\Delta P \\\\) | Pressure loss in the combustion chamber |  \\\\(\\mathrm{Pa} \\\\) | \\\\( P_i - P_o \\\\) | deltaPccb |  
| \\\\( \\eta_{at} \\\\) | Atomization compressor isentropic efficiency | \\\\(\\mathrm{-} \\\\) | | eta_is |  
| \\\\( \\eta_c \\\\) | Combustion efficiency \\\\( 0 < \\eta_c \\le 1 \\\\) | \\\\(\\mathrm{-} \\\\) | Burnt fuel mass divided by the input fuel mass | eta_comb |  
| \\\\( \\Lambda \\\\) | Pressure loss coefficient in the combustion chamber | \\\\(\\mathrm{m}^{-4} \\\\) | | kcham |  
| \\\\( \\Lambda_{at} \\\\) | Atomization pressure loss coefficient | \\\\(\\mathrm{m}^{-4} \\\\) | | kat |  
| \\\\( \\rho_i \\\\) | Air density at the inlet | \\\\(\\mathrm{kg/m}^3 \\\\) | | rhoea |  
| \\\\( \\rho_o \\\\) | Flue gases density at the outlet | \\\\(\\mathrm{kg/m}^3 \\\\) | | rhosf |  
| \\\\( \\rho_m \\\\) | Fluid average density | \\\\(\\mathrm{kg/m}^3 \\\\) | \\\\( \\frac{\\rho_i + \\rho_o}{2} \\\\) | - |  


## Governing equations  

The *GTCombustionChamber* model is based on the following mass and energy balance equations.  
The dry air stoichiometry and the resulting mass fractions are the same for the [boiler](modelica://ThermoSysPro.MultiFluids.Boilers.FossilFuelBoiler) component.  
This set of equations must be completed by the state equations involving \\\\( h_{a,i}, \\\\, h_{at,i}, \\\\, h_{at,o}, \\\\ S_{at,i}, \\\\, T_{g,o}, \\\\, \\rho_i \\\\; \\text{and} \\\\; \\rho_o \\\\).  


### Mass balance equation  

- Validity formulation:   
   
\\\\( \\forall \\dot{m}\\_g \\\\, , \\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\; \\\\text{and} \\\\; \\dot{m}\\_{ws} \\\\)  

- Mathematical formulation:  

$$ \\quad \\dot{m}\\_g = \\\\dot{m}\\_a + \\dot{m}\\_f + \\dot{m}\\_{ws} $$  

- Comments:   
      
Flue gases result from the combustion of fuel with air. The incoming vapor is vaporized and mixed with the flue gases in the combustion chamber.  


### Energy balance equation  

- Validity formulation:   
   
\\\\( \\forall \\\\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\, , \\dot{m}\\_{ws} \\\\; \\text{and} \\\\; \\dot{m}\\_g>0 \\\\)  

- Mathematical formulation:  

$$ \\dot{m}\\_g \\cdot h_{g,o} + W_{at,o} + W_l- \\\\dot{m}\\_a \\cdot h_{a,i} - \\dot{m}\\_f \\cdot (h_f + \\eta_c \\cdot LHV) - \\dot{m}\\_{ws} \\cdot h_{ws,i} - W_{at} = 0  $$  

- Comments:   
      
This equation is used to compute the flue gases specific enthalpy after combustion \\\\( h_{g,o} \\\\).  
The combustion efficiency \\\\(\\eta_c \\\\) and the fuel lower heating value LHV are model inputs.  
The specific enthalpies \\\\( h_f \\\\) and \\\\( h_{a,i} \\\\) are computed using properties tables from the known temperatures \\\\(T_f \\\\) and \\\\(T_{a,i} \\\\).  



### Energy balance equation (without air atomization)  

- Validity formulation:   
   
  \\\\( \\forall \\\\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\, , \\dot{m}\\_{ws} \\\\; \\\\text{and} \\\\; \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   

    $$ \\\\dot{m}\\_a \\cdot h_{a,i} + \\dot{m}\\_f \\cdot (h_f + \\eta_c \\cdot LHV) - W_l - \\dot{m}\\_g \\cdot h_{g,o} + \\dot{m}\\_{ws} \\cdot h_{ws,i} = 0 $$  

- Comments:   

This equation computes the specific enthalpy \\\\( h_{g,o} \\\\).  


### Power of the atomization compressor  

- Validity formulation:   
   
 \\\\( \\eta_{isc} > 0 \\\\; \\text{and} \\\\; \\forall \\dot{m}\\_a \\geq 0 \\\\)  

- Mathematical formulation:  

With air atomization: \\\\( W_{at} = \\\\dot{m}\\_a \\cdot XM_{at} \\cdot \\eta_{isc} \\cdot (h_{at,o} - h_{at,i}) \\\\)  

Without air atomization: \\\\( W_{at} = 0 \\\\)  


### Thermal power extracted by the atomization refrigerant  

- Validity formulation:   
   
 \\\\( \\forall \\dot{m}\\_a \\geq 0 \\\\)  

- Mathematical formulation:  

With air atomization: \\\\( W_{at} = \\\\dot{m}\\_a \\cdot XM_{at} \\cdot \\eta_{isc} \\cdot (h_{a,i} - h_{at,i}) \\\\)  

Without air atomization: \\\\( W_{at} = 0 \\\\)  


### Momentum balance equation for the fluid  

- Validity formulation:   
   
 \\\\( \\forall \\nu \\\\)  

- Mathematical formulation:  

$$ P_o = P_i - \\Lambda \\cdot \\frac{\\rho_m \\cdot \\nu \\cdot | \\nu |}{2} $$  


### Dry air stoichiometry for the combustion of 1 kg fuel  

- Validity formulation:   
   
 \\\\( X_{H_20,a} < 1 \\\\; \\\\text{and} \\\\;\\\\ X_{O_2,a} > 0) \\\\)  

- Mathematical formulation:   
      
$$ E_X = M_O \\cdot \\frac{\\frac{2 \\cdot X_{C,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} - \\frac{X_{O,f}}{M_O}}{\\frac{X_{0_2,a}}{1 - X_{H_2O,a}}} $$  

- Comments:   

    This formulation arises from the chemical reactions considered in the combustion:  

    $$ C + O_2 \\longrightarrow CO_2 $$  

    $$ H + \\frac{1}{4} 0_2 \\longrightarrow H_2O $$  

    $$ S + O_2 \\longrightarrow SO_2 $$  


### \\\\( CO_2 \\\\) mass fraction in the flue gases  

- Validity formulation:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{CO_2,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{CO_2,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{C,f} \\cdot \\frac{M_{CO_2}}{M_C} $$  

- Comments:   

This formulation arises from the chemical reaction considered in the combustion:  

$$ C + O_2 \\longrightarrow CO_2 $$.  


### \\\\( H_2O \\\\) mass fraction in the flue gases  

- Validity formulation:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{H_2O,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{H_2O,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{H,f} \\cdot \\frac{M_{H_2O}}{2 \\cdot M_H} $$  

- Comments:   

This formulation arises from the chemical reaction considered in the combustion:  

$$ H + \\frac{1}{4} O_2 \\longrightarrow H_2O $$  



### \\\\( O_2 \\\\) mass fraction in the flue gases  

- Validity formulation:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{O_2,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{O_2,a} - M_O \\cdot \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot \\left( \\frac{2 \\cdot X_{HC,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} \\right) + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{O,f} $$  

- Comments:   

This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  


### \\\\( SO_2 \\\\) mass fraction in the flue gases  

- Validity formulation:   
   
 \\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{SO_2,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{SO_2,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{S,f} \\cdot \\frac{M_{SO_2}}{M_S}$$  

- Comments:   

This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  


## References  

El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 8.1. Springer Nature Switzerland AG.  
    "));
end GTCombustionChamber;