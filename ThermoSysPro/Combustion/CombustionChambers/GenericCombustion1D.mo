within ThermoSysPro.Combustion.CombustionChambers;

model GenericCombustion1D "Generic combustion chamber 1D"
  parameter Integer NCEL = 7;
  parameter Units.SI.Area Acham = 1 "Average cross-sectional area of the combusition chamber";
  //parameter ThermoSysPro.Units.SI.Area SM[NCEL] = {639.92,198.58,466.48,466.48,466.48,523.79,523.79}
  parameter Units.SI.Area SM[NCEL] = fill(100, NCEL) "Heat exchange area for the node i = projetee )";
  parameter Real RSURF[NCEL] = cat(1, {1.321}, fill(1.409, NCEL - 1)) "Reel surface/projetee surface ";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient kcham = 0.01 "Pressure loss coefficient in the combustion chamber";
  parameter Real Xpth = 0.00 "Thermal loss fraction in the body of the combustion chamber (0-1 over Q.HHV)";
  parameter Real ImbCV = 0 "Unburnt particles ratio in the volatile ashes (0-1)";
  parameter Real ImbBF = 0 "Unburnt particle ratio in the low furnace ashes (0-1)";
  parameter Units.SI.SpecificHeatCapacity Cpcd = 500 "Ashes specific heat capacity";
  parameter Units.SI.Temperature Tbf = 500 "Ashes temperature at the outlet of the low furnace";
  parameter Real Xbf = 0.1 "Ashes ration in the low furnace (0-1)";
  parameter Units.SI.CoefficientOfHeatTransfer Kec = 50 "Convection and conduction(fouling) heat exchange coefficient";
  parameter Real EPSPAR = 0.6 "Combustion chamber walls emissivity";
  //parameter Real hrCorr=1.00 "Corrective term for ratiation heat exchange";
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
  Real XCfuel(start = 0.8) "C mass fraction in the fuel /pur";
  Real XHfuel(start = 0.2) "H mass fraction in the fuel /pur";
  Real XOfuel(start = 0) "O mass fraction in the fuel /pur";
  Real XSfuel(start = 0) "S mass fraction in the fuel /pur";
  Real Xwfuel(start = 0) "H2O mass fraction in the fuel";
  Real XCDfuel(start = 0) "Ashes mass fraction in the fuel /Dryer";
  Units.SI.SpecificEnergy LHVfuel_D(start = 5e7) "Fuel lower heating value /Dryer";
  Units.SI.SpecificEnergy LHVfuel(start = 5e7) "Fuel lower heating value /Brut";
  Units.SI.SpecificHeatCapacity Cpfuel(start = 1000) "Fuel specific heat capacity";
  Units.SI.SpecificEnergy HHVfuel "Fuel higher heating value";
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
  //////////////////////ThermoSysPro.Units.SI.Power Wfuel(start=5e8) "LHV power available in the fuel";
  Units.SI.Power Wpth(start = 1e6) "Thermal losses power";
  Real exc(start = 1) "Combustion air ratio";
  Units.SI.MassFlowRate Qcv(start = 1) "Volatile ashes mass flow rate";
  Units.SI.MassFlowRate Qbf(start = 1) "Low furnace ashes mass flow rate";
  Units.SI.SpecificEnthalpy Hcv(start = 10e3) "Volatile ashes specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy Hbf(start = 10e3) "Low furnace ashes specific enthalpy at the outlet";
  ThermoSysPro.Units.SI.PressureDifference deltaPccb(start = 1e3) "Pressure loss in the combustion chamber";
  Units.SI.SpecificEnthalpy Hrair(start = 10e3) "Air reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrws(start = 10e4) "Water/steam reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfuel(start = 10e3) "Fuel reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrcd(start = 10e3) "Ashes reference specific enthalpy";
  Units.SI.SpecificEnthalpy Hrfg(start = 10e3) "Flue gases reference specific enthalpy";
  Real Vea(start = 0.001) "Air volume mass (m3/kg)";
  Real Vsf(start = 0.001) "Flue gases volume mass (m3/kg)";
  Units.SI.Density rhoea(start = 0.001) "Air density at the inlet";
  Units.SI.Density rhosf(start = 0.001) "Flue gases density at the outlet";
  Units.SI.MassFlowRate Qm(start = 400) "Average mlass flow rate in the combusiton chamber";
  Real Vccbm(start = 0.001) "Average volume mass in the combustion chamber";
  Units.SI.Velocity v(start = 100) "Flue gases reference velocity in the combusiton chamber";
  Units.SI.Temperature Tpi[NCEL](start = fill(400, NCEL)) "Wall temperature for node i";
  Units.SI.Power Ws[NCEL](start = fill(10e6, NCEL)) "Power delivered to each segment";
  Units.SI.Power Wst(start = 50.e6) "Total power exchanged on all segment";
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel "Fuel inlet" annotation(
    Placement(transformation(extent = {{-100, -60}, {-80, -40}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ca "Air inlet" annotation(
    Placement(transformation(extent = {{-10, -100}, {10, -80}}, rotation = 0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg "Flue gases outlet" annotation(
    Placement(transformation(extent = {{-10, 80}, {10, 100}}, rotation = 0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws "Water/steam inlet" annotation(
    Placement(transformation(extent = {{-100, 40}, {-80, 60}}, rotation = 0)));
  Thermal.Connectors.ThermalPort Cth[NCEL] "Thermal W T" annotation(
    Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0)));
protected
  constant Real SIGMA = 5.669e-8 "Boltzman constant W/m^2/K^4";
  constant Real amC = 12.01115 "Carbon atomic mass";
  constant Real amH = 1.00797 "Hydrogen atomic mass";
  constant Real amO = 15.9994 "Oxygen atomic mass";
  constant Real amS = 32.064 "Sulfur atomic mass";
  constant Units.SI.SpecificEnergy HHVcarbone = 32.8e6 "Unburnt carbon higher heating value, CO2 = 3.2791664E+07";
  constant Real RAD = 0.017453293 "pi/180";
  Real amCO2 "CO2 molecular mass";
  Real amH2O "H2O molecular mass";
  Real amSO2 "SO2 molecular mass";
equation
/* Heat transfer */
  Cth.W = -Ws;
  Cth.T = Tpi;
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
  Xwfuel = Cfuel.hum;
  XCDfuel = Cfuel.Xashes;
  LHVfuel_D = Cfuel.LHV;
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
/* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
/* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
/* Air density at the inlet */
  rhoea = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
  Vea = if (rhoea > 0.001) then 1/rhoea else 1/1.1;
/* Flue gases density at the outlet */
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  Vsf = if (rhosf > 0.001) then 1/rhosf else 1/0.1;
  amCO2 = amC + 2*amO;
  amH2O = 2*amH + amO;
  amSO2 = amS + 2*amO;
/* Mass balance equation */
  Qsf = Qea + Qews + Qfuel*(1 - XCDfuel) - Qcv*ImbCV - Qbf*ImbBF;
  Qcv = Qfuel*XCDfuel*(1 - Xbf)/(1 - ImbCV);
  Qbf = Qfuel*XCDfuel*Xbf/(1 - ImbBF);
/* CO2 flue gases mass fraction */
  XsfCO2*Qsf = (Qea*XeaCO2) + ((Qfuel*XCfuel - Qcv*ImbCV - Qbf*ImbBF)*amCO2/amC);
/* H2O flue gases mass fraction */
//XsfH2O*Qsf = Qews + (Qea*XeaH2O+Qfuel*XHfuel* amH2O/2 /amH);
  XsfH2O*Qsf = Qews + (Qea*XeaH2O + Qfuel*XHfuel*amH2O/2/amH) + Xwfuel*Qfuel;
/* O2 flue gases mass fraction */
  XsfO2*Qsf = (Qea*XeaO2) - (Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS)) + (Qfuel*XOfuel);
/* SO2 flue gases mass fraction */
  XsfSO2*Qsf = (Qea*XeaSO2) + (Qfuel*XSfuel*amSO2/amS);
/* LHV conversion from dryer to crude*/
  LHVfuel = -2510000.0*Xwfuel + LHVfuel_D*(1 - Xwfuel);
/* Fuel higher heating value */
  HHVfuel = LHVfuel_D + 224.3e5*XHfuel + 25.1e5*Xwfuel;
/* Thermal losses power */
  Wpth = Qfuel*LHVfuel*Xpth;
/* Combusiton air ratio */
  exc = Qea*(1 - XeaH2O)/((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO) - Qfuel*amO*2*(Qcv*ImbCV + Qbf*ImbBF)/amC)/(XeaO2/(1 - XeaH2O)));
//  exc = Qea*(1 - XeaH2O)/((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO))/(XeaO2c/(1 - XeaH2O)));
/* Pressure losses */
  Pea - Psf = deltaPccb;
  Qm = (Qea + Qfuel + Qews)/2;
  Vccbm = (Vea + Vsf)/2;
  v = Qm*Vccbm/Acham;
  deltaPccb = (kcham*(v^2))/(2*Vccbm);
/* Power delivered to each segment*/
  for i in 1:NCEL loop
    Ws[i] = SIGMA*EPSPAR*RSURF[i]*SM[i]*(Tsf^4 - Tpi[i]^4) + Kec*RSURF[i]*SM[i]*(Tsf - Tpi[i]);
  end for;
  Wst = sum(Ws);
/* Energy balance equation */
  ((Qea + Qews + Qfuel*(1 - XCDfuel))*(Hsf - Hrfg) + Wpth + Qcv*(Hcv - Hrcd) + Qbf*(Hbf - Hrcd) + (Qcv*ImbCV + Qbf*ImbBF)*HHVcarbone) + Wst - (Qfuel*(Hfuel - Hrfuel + LHVfuel) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws)) = 0;
  Hfuel = Cpfuel*(Tfuel - 273.16);
  Hcv = Cpcd*(Tsf - 273.16);
  Hbf = Cpcd*(Tbf - 273.16);
/* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrfuel = 0;
  Hrws = 2501.569e3;
  Hrfg = 2501.569e3*XsfH2O;
  Hrcd = 0;
  annotation(
    Diagram(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, lineThickness = 0.5, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-56, 45}, {-54, 53}, {-50, 57}, {-44, 59}, {-36, 61}, {-26, 61}, {-16, 59}, {-8, 55}, {0, 51}, {2, 48}, {0, 46}, {-2, 45}, {-6, 43}, {-6, 42}, {-4, 42}, {4, 44}, {10, 44}, {16, 43}, {28, 41}, {44, 37}, {28, 29}, {16, 25}, {2, 21}, {-8, 19}, {-16, 17}, {-28, 17}, {-42, 19}, {-50, 21}, {-56, 27}, {-56, 33}, {-52, 37}, {-56, 45}}, lineColor = {255, 0, 0}, lineThickness = 1, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-56, 45}, {-54, 51}, {-48, 55}, {-40, 57}, {-32, 57}, {-22, 55}, {-14, 51}, {-10, 47}, {-14, 43}, {-18, 41}, {-22, 39}, {-22, 37}, {-18, 35}, {-12, 36}, {-8, 36}, {-2, 37}, {2, 37}, {10, 37}, {22, 35}, {-4, 25}, {-18, 21}, {-26, 19}, {-36, 19}, {-42, 21}, {-50, 23}, {-54, 27}, {-56, 33}, {-54, 39}, {-56, 45}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 213, 170}), Polygon(points = {{-51, 39}, {-53, 45}, {-49, 49}, {-45, 51}, {-41, 51}, {-36, 47}, {-33, 43}, {-33, 39}, {-34, 35}, {-37, 31}, {-39, 29}, {-43, 27}, {-47, 27}, {-51, 29}, {-53, 31}, {-53, 33}, {-51, 39}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 255, 170}), Polygon(points = {{-56, -30}, {-54, -22}, {-50, -18}, {-44, -16}, {-36, -14}, {-26, -14}, {-16, -16}, {-8, -20}, {-2, -24}, {0, -26}, {0, -28}, {0, -28}, {-2, -30}, {-6, -32}, {-4, -32}, {4, -30}, {10, -30}, {20, -32}, {28, -34}, {44, -38}, {28, -46}, {16, -50}, {2, -54}, {-8, -56}, {-16, -58}, {-28, -58}, {-42, -56}, {-50, -54}, {-56, -48}, {-56, -42}, {-52, -38}, {-56, -30}}, lineColor = {255, 0, 0}, lineThickness = 1, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-56, -30}, {-54, -24}, {-48, -20}, {-40, -18}, {-32, -18}, {-22, -20}, {-14, -24}, {-10, -28}, {-14, -32}, {-18, -34}, {-22, -36}, {-22, -38}, {-18, -40}, {-12, -40}, {-8, -40}, {-2, -38}, {2, -38}, {10, -38}, {22, -40}, {-4, -50}, {-18, -54}, {-26, -56}, {-36, -56}, {-42, -54}, {-50, -52}, {-54, -48}, {-56, -42}, {-54, -36}, {-56, -30}}, lineColor = {0, 0, 0}, lineThickness = 1, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 213, 170}), Polygon(points = {{-51, -36}, {-53, -30}, {-49, -26}, {-45, -24}, {-41, -24}, {-36, -28}, {-33, -32}, {-33, -36}, {-34, -40}, {-37, -44}, {-39, -46}, {-43, -48}, {-47, -48}, {-51, -46}, {-53, -44}, {-53, -42}, {-51, -36}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 255, 170})}),
    Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, lineThickness = 0.5, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-54, 45}, {-52, 53}, {-48, 57}, {-42, 59}, {-34, 61}, {-24, 61}, {-14, 59}, {-6, 55}, {2, 51}, {4, 48}, {2, 46}, {0, 45}, {-4, 43}, {-4, 42}, {-2, 42}, {6, 44}, {12, 44}, {18, 43}, {30, 41}, {46, 37}, {30, 29}, {18, 25}, {4, 21}, {-6, 19}, {-14, 17}, {-26, 17}, {-40, 19}, {-48, 21}, {-54, 27}, {-54, 33}, {-50, 37}, {-54, 45}}, lineColor = {255, 0, 0}, lineThickness = 1, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-54, 45}, {-52, 51}, {-46, 55}, {-38, 57}, {-30, 57}, {-20, 55}, {-12, 51}, {-8, 47}, {-12, 43}, {-16, 41}, {-20, 39}, {-20, 37}, {-16, 35}, {-10, 36}, {-6, 36}, {0, 37}, {4, 37}, {12, 37}, {24, 35}, {-2, 25}, {-16, 21}, {-24, 19}, {-34, 19}, {-40, 21}, {-48, 23}, {-52, 27}, {-54, 33}, {-52, 39}, {-54, 45}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 213, 170}), Polygon(points = {{-49, 39}, {-51, 45}, {-47, 49}, {-43, 51}, {-39, 51}, {-34, 47}, {-31, 43}, {-31, 39}, {-32, 35}, {-35, 31}, {-37, 29}, {-41, 27}, {-45, 27}, {-49, 29}, {-51, 31}, {-51, 33}, {-49, 39}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 255, 170}), Polygon(points = {{-54, -30}, {-52, -22}, {-48, -18}, {-42, -16}, {-34, -14}, {-24, -14}, {-14, -16}, {-6, -20}, {0, -24}, {2, -26}, {2, -28}, {2, -28}, {0, -30}, {-4, -32}, {-2, -32}, {6, -30}, {12, -30}, {22, -32}, {30, -34}, {46, -38}, {30, -46}, {18, -50}, {4, -54}, {-6, -56}, {-14, -58}, {-26, -58}, {-40, -56}, {-48, -54}, {-54, -48}, {-54, -42}, {-50, -38}, {-54, -30}}, lineColor = {255, 0, 0}, lineThickness = 1, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-54, -30}, {-52, -24}, {-46, -20}, {-38, -18}, {-30, -18}, {-20, -20}, {-12, -24}, {-8, -28}, {-12, -32}, {-16, -34}, {-20, -36}, {-20, -38}, {-16, -40}, {-10, -40}, {-6, -40}, {0, -38}, {4, -38}, {12, -38}, {24, -40}, {-2, -50}, {-16, -54}, {-24, -56}, {-34, -56}, {-40, -54}, {-48, -52}, {-52, -48}, {-54, -42}, {-52, -36}, {-54, -30}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 213, 170}), Polygon(points = {{-49, -36}, {-51, -30}, {-47, -26}, {-43, -24}, {-39, -24}, {-34, -28}, {-31, -32}, {-31, -36}, {-32, -40}, {-35, -44}, {-37, -46}, {-41, -48}, {-45, -48}, {-49, -46}, {-51, -44}, {-51, -42}, {-49, -36}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {255, 255, 170})}),
    Documentation(revisions = "
Author  

Baligh El Hefni   

    ", info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 8.2 of the ThermoSysPro book.   
# Generic combustion 1D  

This component is a combustion chamber for boiler furnace.  
In thermal power plants, the combustion takes place in the furnace.  
The combustion generates high-temperature flue gases, which circulate outside the membrane of the furnace that wraps the tubes where water vaporizes.  

## Modelica component model  

The equations mentioned below are implemented in the component *GenericCombustion1D*, located  
in the *Combustion.CombustionChambers* sub-library.  
The component has 5 connectors:  
- Cws: water/steam at the inlet,  
- Ca: air at the inlet,  
- Cfuel: fuel at the inlet,  
- Cfg: flue gases at the outlet,  
- Cth: thermal flow created through the membrane of the furnace.  

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Combustion.CombustionChambers.GenericCombustion1D.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Combustion.CombustionChambers.GenericCombustion1D.svg)  

## Nomenclature  



| Symbol          | Description                                                         | Unit                          | Definition                | Modelica name |  
|------------------- |---------------------------------------------------------- |---------------------------|------------------------------------- |----------------------------------|  
| A | Average cross-sectional area of the combustion chamber | \\\\( \\mathrm{m}^2 \\\\) || Acham |  
| \\\\( c_{p,cd} \\\\) | Ashes specific heat capacity | \\\\(\\mathrm{J/kg/K} \\\\) || Cpcd |  
| \\\\( c_{p, f} \\\\) | Fuel specific heat capacity | \\\\( \\mathrm{J/kg/K} \\\\) | |Cpfuel |       
| \\\\(E_x \\\\) | Dry air stoichiometry necessary for 1kg fuel combustion | - | Proportion of oxygen in the air at the inlet required to burn 1kg fuel | - |  
| \\\\(E_{X,a} \\\\) | Excess air | \\\\(\\% \\\\) | \\\\( 100 \\cdot \\left(\\frac{\\\\dot{m}\\_a \\cdot (1 - X_{h_2O, a})}{\\dot{m}\\_f \\cdot E_X} - 1 \\right) \\\\) | - |  
| \\\\( h\\_{a, i} \\\\) | Air specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | |  Hea |  
| \\\\(\\tilde{h}_{a, r} \\\\) | Air reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | \\\\(2501569 \\cdot X_{h_2O, a} \\\\) | Hrair |  
| \\\\(h_{bf} \\\\)| Low furnace ashes specific enthalpy at the outlet | \\\\( \\mathrm{J/kg} \\\\) | \\\\( c_{p,cd} \\cdot (T_{bf} - 273.16) \\\\)| Hbf |  
 \\\\( h_c \\\\) | Convective/conductive (+fouling) heat exchange coefficient| \\\\(\\mathrm{W/m^2/K} \\\\) || Kec |  
 \\\\( h_{c,r} \\\\) | Ashes reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |0 | -|  
  \\\\( h_{cv} \\\\) | Volatile ashes specific enthalpy at the outlet | \\\\(\\mathrm{J/kg} \\\\) | \\\\(c_{p,cd} \\cdot (T_{g,o} - 273.16) \\\\) | Hcv |  
| \\\\( h_f \\\\) | Fuel specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | \\\\(c_{p, f} \\cdot (T_f - 273.16) \\\\) | Hfuel |  
| \\\\( \\tilde{h}_{f, r} \\\\) | Fuel reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) | 0 | Hrfuel |  
| \\\\( h_{g, o} \\\\) | Flue gases specific enthalpy at the outlet | \\\\(\\mathrm{J/kg} \\\\) | | Hsf |  
| \\\\( \\tilde{h}_{g, r} \\\\) | Flue gases reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |\\\\(2501569 \\cdot X_{h_2O, g} \\\\) | Hrfg |  
| \\\\( h_{ws, i} \\\\) | Water/steam specific enthalpy at the inlet | \\\\(\\mathrm{J/kg} \\\\) | | Hews |  
| \\\\( h_{ws, r} \\\\) | Water/steam reference specific enthalpy | \\\\(\\mathrm{J/kg} \\\\) |2501569 | Hrws |  
| \\\\( \\text{HHV}_c \\\\) | Unburnt carbon higher heating value | \\\\(\\mathrm{J/kg} \\\\) | \\\\( 32.8 \\times 10^6 \\\\)| HHVcarbone |  
| \\\\(I_{CV} \\\\) | Unburnt particles ratio in the volatile ashes | - | \\\\( 0 \\leq I_{CV} \\leq 1 \\\\) | ImbCV |  
| \\\\(I_{BF} \\\\) | Unburnt particles ration in the low furnace ashes | - | \\\\( 0 \\leq I_{BF} \\leq 1 \\\\) | ImbBF |  
| \\\\( \\text{LHV}_d \\\\) | Fuel lower heating value of the dry matter | \\\\(\\mathrm{J/kg} \\\\) || LHVfuel |  
| LHV | Fuel lower heating value (effective value or crude) | \\\\(\\mathrm{J/kg} \\\\) | \\\\( \\text{LHV}\\_d \\cdot (1-X\\_{W,f})\\\\) \\\\(- 25.1 \\times 10^5 \\cdot X\\_{W,f} \\\\) |  
| \\\\(\\dot{m}\\_a \\\\) | Air mass flow rate | \\\\(\\mathrm{kg/s} \\\\) || Qea |  
| \\\\(\\dot{m}\\_{bf} \\\\) | Low furnace ashes mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | \\\\( \\\\dot{m}\\_f \\cdot X\\_{CD,f} \\cdot X\\_{bf}\\\\) \\\\(\\cdot (1-I\\_{BF}) \\\\) | Qbf |  
| \\\\(\\dot{m}\\_{bf} \\\\) | Volatile ashes mass flow rate | \\\\(\\mathrm{kg/s} \\\\) | \\\\( \\frac{\\dot{m}\\_f \\cdot X\\_{CD,f} \\cdot (1-X\\_{bf})}{1-I\\_{BF}} \\\\) | Qcv |  
| \\\\(\\dot{m}\\_f \\\\) | Fuel mass flow rate | \\\\(\\mathrm{kg/s} \\\\) || Qfuel |  
| \\\\(\\dot{m}\\_g \\\\) | Flue gases mass flow rate | \\\\(\\mathrm{kg/s} \\\\)|| Qsf |  
| \\\\(\\dot{m}\\_m \\\\) | Average mass flow rate in the combustion chamber| \\\\(\\mathrm{kg/s} \\\\) | \\\\(\\dot{m}\\_a + \\frac{\\dot{m}\\_f + \\dot{m}\\_{ws}}{2} \\\\)| Qm |  
| \\\\(\\\\dot{m}\\_{ws} \\\\) | Water/steam mass flow rate | \\\\(\\mathrm{kg/s} \\\\) || Qews |  
| \\\\( M_C \\\\) | Carbon atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 12.01115 | amC |  
| \\\\( M_H \\\\) | Hydrogen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 1.00797 | amH |  
| \\\\( M_O \\\\) | Oxygen atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 15.9994 | amO |  
| \\\\( M_S \\\\) | Sulfur atomic mass | \\\\(\\mathrm{kg/kmol} \\\\) | 32.064 | amS |  
| \\\\( M_{CO_2} \\\\) | \\\\(CO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_C + 2 \\cdot M_O \\\\) | amCO2 |  
| \\\\( M_{H_2O} \\\\) | \\\\(H_2O\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_O + 2 \\cdot M_H \\\\) | amH2O |  
| \\\\( M_{SO_2} \\\\) | \\\\(SO_2\\\\) molar mass | \\\\(\\mathrm{kg/kmol} \\\\) | \\\\(M_S + 2 \\cdot M_O \\\\) | amSO2 |  
| n | Number of segments in the combustion chamber | - || NCEL |  
| \\\\( P_i \\\\) | Fluid pressure at the inlet | \\\\(\\mathrm{Pa} \\\\) || Pea |  
| \\\\( P_o \\\\) | Fluid pressure at the outlet | \\\\(\\mathrm{Pa} \\\\) || Psf |  
| \\\\( R_{S,i} \\\\) | Corrective coefficient for heat exchange area of cell *i* | - || RSURF[i] |  
| \\\\( S_i \\\\) | Heat exchange area for cell *i* | \\\\( \\mathrm{m}^2 \\\\)|| SM[i] |  
| \\\\( T_{a,i} \\\\) | Air temperature at the inlet | \\\\(\\mathrm{K} \\\\) || Tea |  
| \\\\( T_{bf} \\\\) | Ashes temperature at the outlet of low furnace | \\\\(\\mathrm{K} \\\\) || Tbf |  
| \\\\( T_f \\\\) | Fuel temperature at the inlet | \\\\(\\mathrm{K} \\\\) || Tfuel |  
| \\\\( T_{g,o} \\\\) | Flue gases temperature at the outlet | \\\\(\\mathrm{K} \\\\) || Tsf |  
| \\\\( T_{w,i} \\\\) | Furnace wall temperature for cell *i* | \\\\(\\mathrm{K} \\\\) || Tpi[i] |  
| \\\\( \\nu \\\\) | Flue gases velocity in the combustion chamber | \\\\( \\mathrm{m/s} \\\\) | \\\\( \\frac{\\dot{m}_m}{A \\cdot \\rho_m} \\\\) | v |  
| \\\\( W_l \\\\) | Thermal power loss | \\\\( \\mathrm{W} \\\\) | \\\\( \\dot{m}\\_f \\cdot \\text{LHV} \\cdot x\\_{w,l} \\\\)| Wpth |  
| \\\\( W_{s,i} \\\\) | Thermal power exchanged between flue gases and furnace wall for cell *i* | \\\\( \\mathrm{W} \\\\) || Ws[i] |  
| \\\\( W_s \\\\) | Total thermal power exchanged between flue gases and furnace wall | \\\\( \\mathrm{W} \\\\) | \\\\( \\sum_i W\\_{s,i} \\\\) | Wst  |   
| \\\\( X_{C,f} \\\\) | Carbon mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) ||  XCfuel |  
| \\\\( X_{H,f} \\\\) | Hydrogen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) || XHfuel |  
| \\\\( X_{O,f} \\\\) | Oxygen mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XOfuel |  
| \\\\( X_{S,f} \\\\) | Sulfur mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) | | XSfuel |  
| \\\\( X_{W,f} \\\\) | \\\\( H_2O \\\\) mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) || XeaH2O |  
| \\\\( X_{CD,f} \\\\) | Ashes mass fraction in the fuel | \\\\(\\mathrm{-} \\\\) || XCDfuel |  
| \\\\( X_{CO_2,a} \\\\) | \\\\( CO_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaCO2 |  
| \\\\( X_{CO_2,g} \\\\) |  \\\\( CO_2 \\\\)  mass fraction in the flue gasess | \\\\(\\mathrm{-} \\\\) | | XsfCO2 |  
| \\\\( X_{H_2O,a} \\\\) | \\\\( H_2O \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaH2O |  
| \\\\( X_{H_2O,g} \\\\) | \\\\( H_2O \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfH2O |  
| \\\\( X_{O_2,a} \\\\) | \\\\( O_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaO2 |  
| \\\\( X_{O_2,g} \\\\) | \\\\( O_2 \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XsfO2 |  
| \\\\( X_{SO_2,a} \\\\) | \\\\( SO_2 \\\\) mass fraction in the air at the inlet | \\\\(\\mathrm{-} \\\\) || XeaSO2 |  
| \\\\( X_{SO_2,g} \\\\) | \\\\( SO_2 \\\\) mass fraction in the flue gases | \\\\(\\mathrm{-} \\\\) || XSfuel |  
| \\\\(x_{W,l} \\\\) | Thermal loss fraction in the body of the combustion chamber | - | \\\\( 0 \\leq x_{W,l} \\leq 1 \\\\) | Xpth |  
| \\\\( \\Delta P \\\\) | Pressure loss in the combustion chamber |  \\\\(\\mathrm{Pa} \\\\) | \\\\( P_i - P_o \\\\) | deltaPccb |  
| \\\\( \\epsilon \\\\) | Wall emissivity | \\\\(\\mathrm{-} \\\\) || EPSPAR |  
| \\\\( \\Lambda \\\\) | Pressure loss coefficient in the combustion chamber | \\\\(\\mathrm{m}^{-4} \\\\) || kcham |  
| \\\\( \\rho_i \\\\) | Air density at the inlet | \\\\(\\mathrm{kg/m}^3 \\\\) || rhoea |  
| \\\\( \\rho_o \\\\) | Flue gases density at the outlet | \\\\(\\mathrm{kg/m}^3 \\\\) || rhosf |  
| \\\\( \\rho_m \\\\) | Fluid average density | \\\\(\\mathrm{kg/m}^3 \\\\) | \\\\( \\frac{\\rho_i + \\rho_o}{2} \\\\) | - |  
| \\\\( \\sigma \\\\) | Stefan-Boltzmann constant | \\\\(\\mathrm{W/m^2/K^4} \\\\) | \\\\( 5.67 \\times 10^{-8} \\\\) | SIGMA |  


## Governing equations  

The modeling of the combustion chamber for boiler furnace is based on the mass, energy and momentum balance equations.  
This set of equations must be completed by the state equations involving \\\\( h_{a,i}, \\\\, T_{g,o}, \\\\, \\rho_i \\\\; \\text{and} \\\\; \\rho_o \\\\).  


### Mass balance equation  

- Validity domain:   

\\\\( \\forall \\dot{m}\\_g \\\\, , \\dot{m}\\_a \\\\, , \\dot{m}\\_f \\\\; \\\\text{and} \\\\; \\dot{m}\\_{ws} \\\\)  

-   Mathematical formulation:  

$$ \\quad \\dot{m}\\_g = \\\\dot{m}\\_a + \\dot{m}\\_{ws} + \\dot{m}\\_f (1 - X\\_{CD,f} - \\dot{m}\\_{cv} \\cdot I\\_{cv} - \\dot{m}\\_{bf} \\cdot I\\_{BF}) $$  


### Energy balance equation  

- Validity domain:   

\\\\( \\forall \\\\dot{m}\\_a > 0 \\\\, , \\dot{m}\\_f > 0 \\\\; \\text{and} \\\\; \\dot{ws}\\_g \\geq 0 \\\\)  

-   Mathematical formulation:  

$$ (\\dot{m}\\_a + \\dot{m}\\_{ws} + \\dot{m}\\_f \\cdot (1-X_{CD,f})) \\cdot h\\_{g,o} + W\\_l + \\dot{m}\\_{cv} \\cdot h_{cv} $$ $$+ \\dot{m}\\_{bf} \\cdot h_{bf} + (\\dot{m}\\_{cv} \\cdot I_{CV} + \\dot{m}\\_{bf} \\cdot I_{BF}) \\cdot \\text{HHV}\\_c + W_s$$$$ = \\dot{m}\\_f  \\cdot (h_f + \\text{LHV}) + \\dot{m}\\_a \\cdot h\\_{a,i} + \\dot{m}\\_{ws} \\cdot h\\_{ws,i} $$  

- Comments:  

This equation is used to compute the flue gases specific enthalpy after combustion \\\\( h_{g,o} \\\\).  


### Energy balance equation (thermal power exchanged between the flue gases and the furnace wall)  

- Validity domain:   

\\\\( \\forall T\\_{g,o} \\\\; \\text{and} \\\\; T\\_{w,i} \\\\)  

-   Mathematical formulation:  

$$ W\\_s = \\sum\\_{i=1}^n \\sigma \\cdot \\epsilon \\cdot R\\_{S,i} \\cdot (T_{g,o}^4 - T_{w,i}^4) + \\sum\\_{i=1}^n h_c \\cdot S_i \\cdot R\\_{S,i}  \\cdot (T_{g,o} - T_{w,i})  
    $$  


### Momentum balance equation for the fluid (pressure losses)  

- Validity domain:   

\\\\( \\forall \\nu \\\\)  

-   Mathematical formulation:  

$$ P_o = P_i - \\Lambda \\cdot \\frac{\\rho_m \\cdot \\nu \\cdot | \\nu |}{2} $$  


### Dry air stoichiometry for the combustion of 1 kg fuel  

- Validity domain:   

\\\\( X_{H_20,a} < 1 \\\\; \\\\text{and} \\\\;\\\\ X_{O_2,a} > 0 \\\\)  

- Mathematical formulation:   
      
$$ E_X = M_O \\cdot \\frac{\\frac{2 \\cdot X_{C,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} - \\frac{X_{O,f}}{M_O} - 2 \\cdot \\frac{\\dot{m}\\_{cv} \\cdot I_{CV} + \\dot{m}\\_{bf} \\cdot I\\_{BF}}{M_C}}{\\frac{X_{0_2,a}}{1 - X_{H_2O,a}}} $$  

- Comments:  

    This formulation arises from the chemical reactions considered in the combustion:  

    $$ C + O_2 \\longrightarrow CO_2 $$  

    $$ H + \\frac{1}{4} 0_2 \\longrightarrow H_2O $$  

    $$ S + O_2 \\longrightarrow SO_2 $$  


### \\\\( O_2 \\\\) mass fraction in the flue gases  

- Validity domain:   

\\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{O_2,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{O_2,a} - M_O \\cdot \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot \\left( \\frac{2 \\cdot X_{HC,f}}{M_C} + \\frac{X_{H,f}}{2 \\cdot M_H} + \\frac{2 \\cdot X_{S,f}}{M_S} \\right) + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{O,f} $$  

- Comments:  

 This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  


### \\\\( SO_2 \\\\) mass fraction in the flue gases  

- Validity domain:   

\\\\( \\dot{m}\\_g \\neq 0 \\\\)  

- Mathematical formulation:   
      
$$ X_{SO_2,g} = \\frac{\\\\dot{m}\\_a}{\\dot{m}\\_g} \\cdot X_{SO_2,a} + \\frac{\\dot{m}\\_f}{\\dot{m}\\_g} \\cdot X_{S,f} \\cdot \\frac{M_{SO_2}}{M_S}$$  

- Comments:  

This formulation arises from the three chemical reactions mentioned in the dry air stoichiometry equation.  


## References  

El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 8.2. Springer Nature Switzerland AG.  
    "));
end GenericCombustion1D;